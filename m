From: Mr Guillaume Seren <guillaumeseren@gmail.com>
Subject: Re: When a file was locked by some program, git will work stupidly
Date: Mon, 02 Nov 2015 15:41:22 +0100
Message-ID: <144647528273.8071.637981592426422555@t440s>
References: <CABEb4T7V=WEi-ZZm7ywOFASm+=LtAyOz53gqv-jjuzF-3=veeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 02 15:41:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtGId-0004jR-5j
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 15:41:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbbKBOl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 09:41:26 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:33284 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753682AbbKBOl0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Nov 2015 09:41:26 -0500
Received: by wmeg8 with SMTP id g8so60986105wme.0
        for <git@vger.kernel.org>; Mon, 02 Nov 2015 06:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:content-transfer-encoding:from:user-agent
         :to:references:in-reply-to:message-id:subject:date;
        bh=R0BPZO/Q/TXeiMXvHAr8Jkkk2H0fKEj0hrjOl4DRJzs=;
        b=PXNatwThq2uIWGRUeN1XvquA5KCVe+X3PGb2xdj+234HCewNigs2R7VEuSmCttKilH
         iWfPaW11uPk+gkYdBWrMpj11+V3R/FhoV/Wfilz+jajoo8fnjxEUF9DUw1z4oiHSku0N
         wX5r4W0YuodQqQJRlLWBO3X/SLE+XgJKQE6eX9SEiIXBfEBuGTLXB5FKRrKLiYuZyhhH
         qA3efZh0QcPFP6d/JblKTR3SsORKZHD5tpXJmJdDHemKkEHXdb9QMAXk6B1gltcKP8DG
         nqfKMo0fxl9M2LxRMHhlh7LzTRHLJxWt+F6UsZHei1mdeYUSUN1pecdIcNhCTzNFZ9LQ
         ZLbg==
X-Received: by 10.28.55.138 with SMTP id e132mr12915087wma.86.1446475284614;
        Mon, 02 Nov 2015 06:41:24 -0800 (PST)
Received: from localhost (mic92-1-82-67-159-185.fbx.proxad.net. [82.67.159.185])
        by smtp.gmail.com with ESMTPSA id u64sm18487875wmd.6.2015.11.02.06.41.23
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2015 06:41:24 -0800 (PST)
User-Agent: alot/0.3.6
In-Reply-To: <CABEb4T7V=WEi-ZZm7ywOFASm+=LtAyOz53gqv-jjuzF-3=veeA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280691>

Quoting dayong xie (2015-11-02 05:56:55)
> To be specific
> In my Unity project, there is a native plugin,  and plugin's extension
> is .dll, and this plugin is
> under git version control, when Unity is running, the plugin file will
> be locked.
> If i merge another branch, which contains modification of the plugin,
> git will report error, looks
> like:
> error: unable to unlink old 'xxxxxxx/xxx.dll' (Permission denied)
> This is not bad, however, the unfinished merge action will not revert
> by git, a lot of changes
> produced in repository.
> usually it makes me crazy, even worse, some of my partners are not
> good at using git.
> Of course, this problem can be avoided by quit Unity, but not every
> time we can remember. In
> my opinion, git should revert the unfinished action when the error
> occurred, not just stop.
> 
> -- 
> --------------------------------------------------------------
> Best Regards,
> John Xie
> --------------------------------------------------------------
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--------------------
| Mr Guillaume Seren
|
| website: http://www.guillaumeseren.com/
| github: https://github.com/GuillaumeSeren
--------------------
