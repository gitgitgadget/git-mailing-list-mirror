From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: jgit and ignore
Date: Sun, 1 Mar 2009 07:54:55 -0500
Message-ID: <9e4733910903010454u662eb5afob45f608321660500@mail.gmail.com>
References: <9e4733910902280831j70448ce9h7239f14e13b92b76@mail.gmail.com>
	 <20090228172622.GC26689@spearce.org> <49AA5F64.6070207@pelagic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Sun Mar 01 13:56:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdlDW-00062x-Np
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 13:56:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752827AbZCAMy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 07:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752662AbZCAMy6
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 07:54:58 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:32812 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693AbZCAMy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 07:54:57 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1283270yxm.1
        for <git@vger.kernel.org>; Sun, 01 Mar 2009 04:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=q0waaO0yr3x4wH5kGFqZR/A5eq4LqQLNGoRTw3r9NRg=;
        b=o2XjqWrkbIvsXDLgXIENwlGDcWNAvVX982DzSdsu7ITLrGbr8nXRRahczhC2ACRA3s
         EwG6C16acUQ+S5qpWvSVx4clHTjA6BeshtQ41zp2LRZ7T/WZlrIZXDobQ5KSW37VsMHW
         Eid2tao1+iWLWs1HA6Dy/hRm1eS3ynqd3fXXk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gBeiFE5u3IJg78ztd1zI6CHnv8LYSn+CpxdLgzupJUZKqjh+YmCBEcyRdfZFFfEsXe
         MpdFu9vaKb4hf9HXQVGo0Og6KHPhMFUQOFHPk7L4vFcs2vMbBHJTFbTnKcnVPKfWb/Hd
         c+ng7KBx0Vu1bDQNyWSdXARxP1Ajo68XCG3VY=
Received: by 10.220.95.202 with SMTP id e10mr1412679vcn.12.1235912095167; Sun, 
	01 Mar 2009 04:54:55 -0800 (PST)
In-Reply-To: <49AA5F64.6070207@pelagic.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111840>

On Sun, Mar 1, 2009 at 5:11 AM, Ferry Huberts (Pelagic)
<ferry.huberts@pelagic.nl> wrote:
> Shawn O. Pearce wrote:
>> Jon Smirl <jonsmirl@gmail.com> wrote:
>>> I'm using jgit in eclipse. Works great for me.
>>
>> Yay!
>>
>>> I have a couple of generated files in my working directory. There
>>> doesn't seem to be any UI for ignoring them. Is it there and I just
>>> can't find it?
>>
>> EGit doesn't (yet) honor the .gitignore files like it should. Someone
>> (Ferry i-forget-the-rest-of-his-name) is working on adding ignore
>> support and has patches in flight for at least some of it.
>>
> Ferry i-do-remember-my-name Huberts is working on it :-)
>
> I have most of it working in a basic form already but am currently
> refactoring things to take care of some nasty little details.
> Expect something to arrive within (my best guesstimate) about 3 to 4
> weeks. after next week I'll be skiing for a week, so no coding then :-)
>
> For the new functionality:
> You don't really need a UI: just add a .gitignore file with a pattern
> and the plugin will pick it up and show you what is ignored by means of
> a nice little decoration.

I expected it to work by right clicking the file and picking
team/ignore. This would add the file name .gitignore and automatically
add .gitignore to my commit. It would also alter the eclipse filter to
make the file disappear in the eclipse browser.


>
> Ferry
>



-- 
Jon Smirl
jonsmirl@gmail.com
