From: Patrick Notz <patnotz@gmail.com>
Subject: Re: post-receive email
Date: Wed, 18 Feb 2009 06:36:19 -0700
Message-ID: <1cd1989b0902180536o48a216edu3b835f3ce9b704c4@mail.gmail.com>
References: <556409.61398.qm@web35708.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Arya, Manish Kumar" <m.arya@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 14:37:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZmcY-0006CW-Ck
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 14:37:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752308AbZBRNgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 08:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751601AbZBRNgX
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 08:36:23 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:38208 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbZBRNgW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 08:36:22 -0500
Received: by bwz5 with SMTP id 5so5426645bwz.13
        for <git@vger.kernel.org>; Wed, 18 Feb 2009 05:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hDvNlaCnU1IZ0NioAJeziLMNDAU9Jf8M72CoDUdtHos=;
        b=MxbZ12sdQ8Fk5a6EBRsM1MuLxWewLBshEPUEZ5bCRq9Lz92W3H7RgbHiTBJ1ckgqBX
         4eTSxEZA07jaKMXjPIYNU7w20Uv0mYcEUnhI/8j2Mauq6IWChdtOxxdxV91j5S9A5NWL
         3YVWtfR9bdKKdO3vLc9ybiJG9vP5dPIcgNMfA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=G9WcO3nN1kZaJpJRUY2XgqbeTocF00CqIf3I3bXp0RzF5H3yHT1Yuu5Y48dXUjJU3U
         4lYuE8mKEfzcaTt4ZTSlxLaIe47NAFrKeocG0c//ndSSMDCwp4ROWkXN5Vtohz9Z7vkZ
         cFMyTXOsZop28TfHWkgRSNdrrXep6V0DE2deY=
Received: by 10.103.131.18 with SMTP id i18mr383302mun.74.1234964180012; Wed, 
	18 Feb 2009 05:36:20 -0800 (PST)
In-Reply-To: <556409.61398.qm@web35708.mail.mud.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110540>

On Wed, Feb 18, 2009 at 5:44 AM, Arya, Manish Kumar <m.arya@yahoo.com> wrote:
>
> Hi,
>
>  I am using git 1.6.1
>
> I have configured post-receive hook for sending emails on remote push activity.

Are you using the example contrib/hooks/post-receive-email that comes with Git?

>
> But I am getting this error while push. any one using this script for email. can you suggest some other working script for this ?
>
> ----------------------------------
> Counting objects: 5, done.
> Compressing objects: 100% (3/3)   Compressing objects: 100% (3/3), done.
> Writing objects: 100% (3/3)   Writing objects: 100% (3/3), 344 bytes, done.
> Total 3 (delta 1), reused 0 (delta 0)
> hooks/post-receive: syntax error at line 73: `oldrev=$' unexpected
> error: hooks/post-receive exited with error code 2
> Pushing to ssh://xxx.xxx.xxx.net/opt/repos/mka.git
> To ssh://xxx.xxx.xxx.net/opt/repos/mka.git
>   db4b382..186b0af  master -> master
> -----------------------------------
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
