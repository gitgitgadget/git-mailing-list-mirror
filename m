From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Why do base objects appear behind the delta in packs?
Date: Tue, 29 Aug 2006 15:23:52 -0400
Message-ID: <9e4733910608291223s7ca574bfh88627f2bec60e424@mail.gmail.com>
References: <20060829134233.GA21335@spearce.org> <ed1kn3$c3r$1@sea.gmane.org>
	 <20060829162747.GA21729@spearce.org>
	 <7v8xl7moo7.fsf@assigned-by-dhcp.cox.net>
	 <20060829174448.GD21729@spearce.org>
	 <Pine.LNX.4.64.0608291410290.9796@xanadu.home>
	 <20060829183239.GH21729@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 29 21:24:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GI9Bs-00087X-Oh
	for gcvg-git@gmane.org; Tue, 29 Aug 2006 21:24:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965115AbWH2TXy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Aug 2006 15:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965261AbWH2TXy
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Aug 2006 15:23:54 -0400
Received: from nz-out-0102.google.com ([64.233.162.207]:33800 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965115AbWH2TXx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Aug 2006 15:23:53 -0400
Received: by nz-out-0102.google.com with SMTP id n1so1372977nzf
        for <git@vger.kernel.org>; Tue, 29 Aug 2006 12:23:52 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bOt6LideNtvOGCFlI3i53j3/1sHSdo/z2wljTs+Z7BTMbjHkJ6FNpBYEpXHqs64NDNRvkuafk9svCva40R8AD9mR6PH8AptVzkuqxXCsrtVJ69zKT/sFw1MIpw8jJi+kZ5hvsC4Ze5VDa4L0BB/PFVY8xBMtklf/M4V/YJHUUV0=
Received: by 10.65.154.10 with SMTP id g10mr9012961qbo;
        Tue, 29 Aug 2006 12:23:52 -0700 (PDT)
Received: by 10.65.133.17 with HTTP; Tue, 29 Aug 2006 12:23:51 -0700 (PDT)
To: "Shawn Pearce" <spearce@spearce.org>
In-Reply-To: <20060829183239.GH21729@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26214>

On 8/29/06, Shawn Pearce <spearce@spearce.org> wrote:
> I don't have Jon's cvs2svn code and I don't know if its ready for
> public consumption yet.  git-fast-import however looks like its
> almost there, so I'm making the URL publicly available for those
> that may be interested in it.

If anyone is interested in cvs2svn mods let me know (they are in
Python) and I will send you a snap shot. The current code gets all the
blobs, tree and commits into a pack via fast-import, but the trees not
being generated correctly for complex branching when there are issues
with the symbols in CVS.

-- 
Jon Smirl
jonsmirl@gmail.com
