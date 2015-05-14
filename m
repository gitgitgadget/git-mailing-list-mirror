From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] tree-walk: learn get_tree_entry_follow_symlinks
Date: Thu, 14 May 2015 15:38:15 -0700
Message-ID: <xmqq382yiy3s.fsf@gitster.dls.corp.google.com>
References: <1431640695-24741-1-git-send-email-user@ubuntu>
	<1431640695-24741-2-git-send-email-user@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 15 00:38:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yt1lm-0004E2-6O
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 00:38:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965030AbbENWiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 18:38:18 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:34162 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964836AbbENWiR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 18:38:17 -0400
Received: by igblo3 with SMTP id lo3so20398114igb.1
        for <git@vger.kernel.org>; Thu, 14 May 2015 15:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=8D4Gx6c3UAPlW7ojXUDy/Sqv1nn6wTxtOfweiTg2wT8=;
        b=Do/wHj7bqizTc+iWcXmomDmHbS1FPZqSUrbFV3j/S2lay8+g+QeNnty3tCaJwu7K2d
         VcgZ1HQQvs1pOH8bslk2+Qi2477bLhw9gzZuVQWjRSm+ul2O+w2dt815/W8F2/RDcpWF
         uy11rnHq/si75Xi4/c04QXQFR91W5upcOE0VCajW3boEwv94XapN0uI2w506wMOoxebr
         Q+vZ9eYTNtGvL6Q/1DHf85Y7ObkWw4WyA174nGyrMfGJfj96oH680BwCzicREroOpG3d
         vmZrSlaJXwJyPj29q/6y+pHmsl5flsu4YU8f4S6SHCUfBafrLbdom5sgX5QC51KjqFoT
         W6gQ==
X-Received: by 10.107.164.209 with SMTP id d78mr8381366ioj.73.1431643097048;
        Thu, 14 May 2015 15:38:17 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1148:d596:44de:a92d])
        by mx.google.com with ESMTPSA id f126sm317976ioe.21.2015.05.14.15.38.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 14 May 2015 15:38:16 -0700 (PDT)
In-Reply-To: <1431640695-24741-2-git-send-email-user@ubuntu> (David Turner's
	message of "Thu, 14 May 2015 17:58:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269118>

David Turner <dturner@twopensource.com> writes:

> From: David Turner <dturner@twitter.com>

This overrides what you have in your e-mail header X-<.

I'll cope; no need to resend only for this issue.

Thanks.
