From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [RFC PATCHv3] repack: rewrite the shell script in C.
Date: Sun, 18 Aug 2013 08:41:51 -0700
Message-ID: <DC7C72E5-8B52-48B2-B10B-1095118865B1@gmail.com>
References: <5210DB77.3090004@googlemail.com> <1376836587-25248-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, l.s.r@web.de, mfick@codeaurora.org,
	apelisse@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	pclouds@gmail.com, iveqy@iveqy.com, gitster@pobox.com
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Aug 18 17:42:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VB57A-0002do-85
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 17:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752185Ab3HRPl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 11:41:56 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:39123 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301Ab3HRPlz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 11:41:55 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp2so3982879pbb.14
        for <git@vger.kernel.org>; Sun, 18 Aug 2013 08:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=15xGiscZ+QMzkT650iOoVgeJGOC/eKQ41LZYqmxD6NI=;
        b=gXiJ9WpBCsCiSEaNrvKI21eyjlB2EbFEjmt7uf18UZSJvbXiilR0fOSgCqLnVCWpMv
         BoEutT69RjOkeXWCn0B/N2L/kMJsiNO7g8aCOWTzzl0ryyOEX7f5yBfLkwHTsHrzkPLh
         7wl+r39MscN/ScWdCI89rPXJMN4cNuVlxAamVCC9tWbxCRJxgsUxMXvthwBsea/LznKe
         PoJwceXZqSpZwgxCU4OQXImo38bObtLv/KS4F2U9TqQ5YQEr0TyJ8lKGe/IbyDgdkqag
         z2yvQK6x0Qxml5MyCK9d0rapzIqjJ3x4cufT+5MUfG9ZLAcQZvkPganTGLSVMjnmntWh
         Qkqw==
X-Received: by 10.67.23.71 with SMTP id hy7mr8476894pad.99.1376840515280;
        Sun, 18 Aug 2013 08:41:55 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id ai6sm10305454pad.15.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 18 Aug 2013 08:41:54 -0700 (PDT)
In-Reply-To: <1376836587-25248-1-git-send-email-stefanbeller@googlemail.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232480>

On Aug 18, 2013, at 07:36, Stefan Beller wrote:

> +			fprintf(stderr,
> +				"WARNING: Some packs in use have been renamed by\n"
> +				"WARNING: prefixing old- to their name, in order to\n"
> +				"WARNING: replace them with the new version of the\n"
> +				"WARNING: file.  But the operation failed, and\n"
> +				"WARNING: attempt to rename them back to their\n"
> +				"WARNING: original names also failed.\n"

Bad grammar "But the operation failed, and attempt to rename them ...".

How about "But the operation failed, and the attempt to rename  
them ..." instead.
