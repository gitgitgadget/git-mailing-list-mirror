From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 04/10] Change "tracking branch" to "remote-tracking
 branch"
Date: Sat, 23 Oct 2010 13:48:53 -0500
Message-ID: <20101023184853.GH21040@burratino>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
 <1287851481-27952-5-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Thore Husfeldt <thore.husfeldt@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sat Oct 23 20:52:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9jCz-00019Q-Un
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 20:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758204Ab0JWSwp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Oct 2010 14:52:45 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:34272 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756619Ab0JWSwo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Oct 2010 14:52:44 -0400
Received: by ywk9 with SMTP id 9so1416815ywk.19
        for <git@vger.kernel.org>; Sat, 23 Oct 2010 11:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=R00IdsFoCE/PJaRN1p0khHfDUFxPdnLX510unKCHmfc=;
        b=WN9+VrakQGjWWJIsRxfNQJ8n2GbF587hnlr5biEzJeBuqOzLMkh6E5Ew6QFRQAJFx5
         dUFWTVRPja863JY025vDS4+EJQWi6YjbDN11/fqjQpODvFVcR1q/V2e7AMQPd4H0ARxn
         6xQcePns6GQrh+cols69s5gOzRUaWVRW713gU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Txpx9ksObOleiKxdcU9UL+V0pGLqolPdZ8P1koq3eBLFvMeBCWVG1BcRAkIofyuQUu
         y/qn/4PBSyl+huM96aXrzOpt9BXTjBn5akoangZsSmJ9+k+2q+SU6rt8IaNKuV/lzp5g
         N3TXwhFXN7K/cPiVO5bQtHG4nIGpJ2F4S2FEA=
Received: by 10.151.99.12 with SMTP id b12mr4716852ybm.193.1287859963909;
        Sat, 23 Oct 2010 11:52:43 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id m45sm3679270yha.11.2010.10.23.11.52.42
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 23 Oct 2010 11:52:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1287851481-27952-5-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159811>

Matthieu Moy wrote:

> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -131,7 +131,7 @@ to point at the new commit.
>  	you have. In such these cases, you do not make a new <<def_merge,merge>>
>  	<<def_commit,commit>> but instead just update to his
>  	revision. This will happen frequently on a
> -	<<def_tracking_branch,tracking branch>> of a remote
> +	<<def_remote_tracking_branch,remote-tracking branch>> of a remote
>  	<<def_repository,repository>>.

Why not keep the anchor name, like so:

	<<def_tracking_branch,remote-tracking branch>>

(for brevity and to keep old links valid)?
