From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] rev-parse doc: clarify use of optional / required
 arguments
Date: Mon, 14 Oct 2013 07:36:32 -0700
Message-ID: <20131014143632.GD21200@google.com>
References: <1381760611-9573-1-git-send-email-boklm@mars-attacks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Vigier <boklm@mars-attacks.org>
X-From: git-owner@vger.kernel.org Mon Oct 14 16:36:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVjGD-0007rD-TO
	for gcvg-git-2@plane.gmane.org; Mon, 14 Oct 2013 16:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092Ab3JNOgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 10:36:37 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:50754 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932082Ab3JNOgg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 10:36:36 -0400
Received: by mail-pd0-f171.google.com with SMTP id g10so7411568pdj.2
        for <git@vger.kernel.org>; Mon, 14 Oct 2013 07:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Uq2MDkL2q2LsiD4loeHH7lFQCuCuxzPBRIiX1mcWQAI=;
        b=K3nQoJnUm7gl9rwy+quv/s7cFHGLtSUN42JfGbbcJjcNqlCbug7P68ifu2s1IeTexQ
         c+PLcKS1DOuRCVeuKsp/5CltkyL5kzGCLUk03PA8e6EfquDotQU3gEQiVoPsIvDiKlTU
         owyPtJp0UHk3WV2UjjEG1celPGeyDWiDjnVii1ldyLUMqeol+9jYoflH+PaYgr81qA/G
         G7AC81nlCNKSotm3K8lNek1uzhkI0BS95rlV8qosxGDVjmJOGfWCh+RvQTlCHltVTkTD
         wOXzom4THF9UHINGMpi6Cx51HVvXl3Gs/V4VZUTSY8DjNcqM3WnimnZUa2oaW530BU0L
         VPDw==
X-Received: by 10.68.189.40 with SMTP id gf8mr3109311pbc.150.1381761395037;
        Mon, 14 Oct 2013 07:36:35 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ik1sm34499648pbc.9.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 14 Oct 2013 07:36:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1381760611-9573-1-git-send-email-boklm@mars-attacks.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236103>

Nicolas Vigier wrote:

> "the option is optional" was confusing as it is not the option but its
> argument which is optional.
>
> Signed-off-by: Nicolas Vigier <boklm@mars-attacks.org>

Thanks.

[...]
> --- a/Documentation/git-rev-parse.txt
> +++ b/Documentation/git-rev-parse.txt
> @@ -259,9 +259,10 @@ Each line of options has this format:
[...]
> -	* Use `?` to mean that the option is optional (though its use is discouraged).
> +	* Use `?` if the option takes an optional argument (though its use is
> +	  discouraged).

This still seems confusing: the argument's use is discouraged?

Would something like the following make sense?

	* Use `?` if [...]. This is used for historical options
	  that once took no argument and later gained an optional
	  argument. Use of this feature for new options is
	  discouraged.

Hope that helps,
Jonathan
