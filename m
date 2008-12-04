From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: Re: git-gui: Warn when username and e-mail address is unconfigured?
Date: Fri, 5 Dec 2008 00:30:15 +0300
Organization: HOME
Message-ID: <200812050030.16467.angavrilov@gmail.com>
References: <Pine.LNX.4.64.0812041141160.9969@ds9.cixit.se> <bd6139dc0812041104s26ae149foeafa489e65aeb584@mail.gmail.com> <b9fd99020812041254l5d1fa383m4fcc3b40f6fabacb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: sverre@rabbelier.nl, "Peter Krefting" <peter@softwolves.pp.se>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jeremy Ramer" <jdramer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 22:33:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8Loh-0003x1-L3
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 22:33:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755193AbYLDVbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 16:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755081AbYLDVbh
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 16:31:37 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:24344 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754085AbYLDVbg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 16:31:36 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2948199fgg.17
        for <git@vger.kernel.org>; Thu, 04 Dec 2008 13:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=SQIl7BjffKRdOAxtgDEx2FD1McypIpUqjhNuCblZd94=;
        b=D6fEzmOa9/RwV85oLtCVNeps0UuiGA7nGZi6Ebp1L9KntYAEtNTt6jl7tRgak3Wfuy
         beHrQNQtlZrAVu+so5MYilV+gAUkGU1PhOdEONFHppYZcpcTs/fI4CyBJLkWRdenP+gz
         danZxJ6epSYc88ePZOMJQi2rtw95yL75cqEGA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=o0YfvxAOVf2oQc3psP7gdyU0dCY1JYz6avqjovL8IBOTNGrfN78nECDFxdmSjk+nzZ
         Pnev6ma7m7/tAHb/9D6agAezaFgMqcm1VLYp2Bh+ARCu031UagRHLQbhURZrQ/U+vJga
         nySI62nX+fK/a8Vk13rJCtfFzDOQOgWBofPxk=
Received: by 10.181.223.2 with SMTP id a2mr5172139bkr.184.1228426294211;
        Thu, 04 Dec 2008 13:31:34 -0800 (PST)
Received: from keydesk.localnet ([92.255.85.78])
        by mx.google.com with ESMTPS id h2sm3603685fkh.29.2008.12.04.13.31.33
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 04 Dec 2008 13:31:33 -0800 (PST)
User-Agent: KMail/1.10.3 (Linux/2.6.27.5-123.fc10.i686; KDE/4.1.3; i686; ; )
In-Reply-To: <b9fd99020812041254l5d1fa383m4fcc3b40f6fabacb@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102368>

On Thursday 04 December 2008 23:54:00 Jeremy Ramer wrote:
> On Thu, Dec 4, 2008 at 12:04 PM, Sverre Rabbelier <alturin@gmail.com> wrote:
> > On Thu, Dec 4, 2008 at 17:05, Jeremy Ramer <jdramer@gmail.com> wrote:
> >> That's strange. I am using git 1.6.0.4 on cygwin and I get a warning
> >> message every time I start git gui.  I actually find this really
> >> annoying and would like a way to turn this warning message off.
> >
> > git config --global user.name "Your Name"
> > git config --global user.email "you@example.com"
> >
> 
> I have done that.  I still get the warning message every time I start git gui.
> --

What does it say precisely? I.e. is it perhaps the warning about subprocesses
possibly ignoring the value of environment variables?

Alexander
