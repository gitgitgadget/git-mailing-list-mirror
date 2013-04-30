From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 3/6] sha1_name: avoid Yoda conditions
Date: Tue, 30 Apr 2013 17:04:57 -0500
Message-ID: <CAMP44s3osZJO1P6_KoPVON0cOSAD5D-OZmL=aKGkcWReortiCw@mail.gmail.com>
References: <1367358554-4257-1-git-send-email-felipe.contreras@gmail.com>
	<1367358554-4257-4-git-send-email-felipe.contreras@gmail.com>
	<7vehdrbrvz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>,
	"Duy Nguyen\" <pclouds@gmail.com>"@b-sasl-quonix.pobox.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 01 00:05:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXIfX-0000QR-U8
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 00:05:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933600Ab3D3WFA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 18:05:00 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:39578 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755642Ab3D3WE7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 18:04:59 -0400
Received: by mail-la0-f47.google.com with SMTP id em20so880417lab.20
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 15:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=dq+H/UduFKWEJafKicD2wo3Ta6J1Fhl4lrP/T6Vez1E=;
        b=kkP4EGJtkxU7TRNyV+cxbSWfXOg35ZFOqlBZdxrJ/uVOtR6wgWnmIL3cRZ2SGTu8To
         g+rHSknfU9uWGekoPcdgYFfgKlsvFDOfZBJHWT5o8PckEJrwJT8QfxyzhpND1u5BVIqX
         D9SYnCbw6tiRDkeg+8v9ZCbp+X7EKtQ+Rcn6oqRK8iLcHaa4oOYXdWwUd1Ns7Cfmstqx
         jn3KWyZ4xdQSdL27rmo0m/xgKzKPNWYOnaa+qxoBa4lAVQZ3WVJKF9fhvUR8csR0MJ8D
         66uieXtLhhQFYZW9Ei87TnIojOC0wnQ8pzpN4nBzBmAKonkwUhqbGljHLtLrVNVpLis6
         84IQ==
X-Received: by 10.112.17.36 with SMTP id l4mr278275lbd.103.1367359497567; Tue,
 30 Apr 2013 15:04:57 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Tue, 30 Apr 2013 15:04:57 -0700 (PDT)
In-Reply-To: <7vehdrbrvz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223023>

On Tue, Apr 30, 2013 at 5:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> What is a Yoda condition?

---
Using if (constant == variable) instead of if (variable == constant),
like if (4 == foo).

Because it's like saying "if blue is the sky" or "if tall is the man".
---

-- 
Felipe Contreras
