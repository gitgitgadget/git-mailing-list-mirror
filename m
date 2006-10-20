From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 20 Oct 2006 14:15:15 -0400
Message-ID: <9e4733910610201115g1790b5am55105bf0c662a0da@mail.gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	 <ehao3e$2qv$1@sea.gmane.org> <4538EC8F.7020502@utoronto.ca>
	 <200610201821.34712.jnareb@gmail.com> <45390168.6020502@utoronto.ca>
	 <20061020172125.GF18019@spearce.org>
	 <Pine.LNX.4.64.0610201045550.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn Pearce" <spearce@spearce.org>,
	"Aaron Bentley" <aaron.bentley@utoronto.ca>,
	"Jakub Narebski" <jnareb@gmail.com>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 20:15:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gaytt-0003U5-Ma
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 20:15:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992561AbWJTSPS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 14:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992615AbWJTSPS
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 14:15:18 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:58014 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S2992561AbWJTSPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 14:15:16 -0400
Received: by nz-out-0102.google.com with SMTP id z3so408604nzf
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 11:15:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Yg4Dvb9DbljT6TWfMOoi5zpfDF+XYGWG1CoDgFK4GbYRGekknBSIvYcpqWMdeAhSSlWDd4NSxCrhLtTUTzNCDT+CDe9sOkD7KGCqVschpwtvP0QSllhxenbOpGy+7Q4wTtJa85y8moLz2cgfvz44UdoMpb3cuKhBB7CPYn1H5UI=
Received: by 10.35.121.2 with SMTP id y2mr1083679pym;
        Fri, 20 Oct 2006 11:15:15 -0700 (PDT)
Received: by 10.35.60.14 with HTTP; Fri, 20 Oct 2006 11:15:15 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610201045550.3962@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29516>

On 10/20/06, Linus Torvalds <torvalds@osdl.org> wrote:
> So yeah, I've seen a few strange cases myself, but they've actually been
> interesting. Like seeing how much of a file was just a copyright license,
> and then a file being considered a "copy" just because it didn't actually
> introduce any real new code.

It may be worth doing something special for licenses. Logs of small
Mozilla files are also getting tripped up by the large copyright
notices. The notices take up a lot of space too. The Mozilla license
has been changed five times. That is 110,000 files times one to five
licenses at 800-1500 characters each. 500MB+ of junk before
compression.

You could have a file of macro substitutions that is applied/expanded
when files go in/out of git. The macros would replace the copyright
notices improving the move/rename tracking and the reducing repository
size. The macros could be recorded out of band to eliminate the need
for escaping the file contents. Even simpler, the only valid place for
the macro could be the beginning of the file.

-- 
Jon Smirl
jonsmirl@gmail.com
