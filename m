From: Gary Yang <garyyang6@yahoo.com>
Subject: Re: How to hide a git repository?
Date: Mon, 24 Nov 2008 18:16:21 -0800 (PST)
Message-ID: <900638.56188.qm@web37904.mail.mud.yahoo.com>
References: <962463.96236.qm@web37905.mail.mud.yahoo.com>
Reply-To: garyyang6@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 25 03:17:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4nUg-0000Uu-Nm
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 03:17:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752747AbYKYCQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2008 21:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752595AbYKYCQX
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 21:16:23 -0500
Received: from web37904.mail.mud.yahoo.com ([209.191.91.166]:24517 "HELO
	web37904.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752546AbYKYCQW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Nov 2008 21:16:22 -0500
Received: (qmail 61111 invoked by uid 60001); 25 Nov 2008 02:16:21 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Message-ID;
  b=x/rbiSaMLJAD6/Se5QZObMWqOoKG6l9BHaFzXii99J8Ed7rGM7RJzYnxM9WBYIjMNdkBt4szzsi88tvf8Eba0ECnkUEB8GRKFra0cvayFVuGEYfBOYTSFomJRGorT8BX3ojqjbbs1/4otKwf+2qyL5wttnLLj6auBK4vHAsMMa4=;
X-YMail-OSG: bef8Xp8VM1kvtUbjPTFAu87DXugR4W7..LL1cQxb3Zo9IeDMPXNLkWPcWx3X69OTc9ZH5dRZtQ3qVHkk5mHsyl9hQ3fyinB3Z6kodOy9Yqxto8JxAKsK9_XcTKTBu73CSLaqIEB3bkBenapYfIeYbTNOsjzq5sAHsToNd_wQZnVz1ibI8xraoNKaT5Ui
Received: from [76.195.33.70] by web37904.mail.mud.yahoo.com via HTTP; Mon, 24 Nov 2008 18:16:21 PST
X-Mailer: YahooMailWebService/0.7.260.1
In-Reply-To: <962463.96236.qm@web37905.mail.mud.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101643>

Do I have to create two git servers? One is for public to download the released code. For example: gitpub.mycompany.com:/pub/linux/kernel. gitpub.mycompany.com is accessible to public. Another is for internal development. For example: gitdev.mycompany.com:/dev/linux/kernel. gitdev.mycompany.com is only accessible to our development team. I push code from gitdev.mycompany.com:/dev/linux/kernel to gitpub.mycompany.com:/publinux/kernel once we completed our development. Is this the only way to do it? 


--- On Mon, 11/24/08, Gary Yang <garyyang6@yahoo.com> wrote:

> From: Gary Yang <garyyang6@yahoo.com>
> Subject: How to hide a git repository?
> To: git@vger.kernel.org
> Date: Monday, November 24, 2008, 4:32 PM
> We have two repositories, one is /pub/git/dev/linux/kernel,
> another is /pub/git/pub/linux/kernel. The
> /pub/git/pub/linux/kernel is open to public for people to
> download released code. /pub/git/dev/linux/kernel is used
> for our development. We would like to hide
> /pub/git/dev/linux/kernel from public. How to do it?
> 
> Why we want to hide /pub/git/dev/linux/kernel from public?
> We work on our development at /pub/git/dev/linux/kernel. We
> push our released code to /pub/git/pub/linux/kernel from
> /pub/git/dev/linux/kernel once we completed our development.
>  We do not want people to download code from
> /pub/git/dev/linux/kernel since it is not stable.  
> 
> 
> 
> 
> 
> 
>       
> --
> To unsubscribe from this list: send the line
> "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html


      
