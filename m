From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v1 25/25] contrib: remove 'mw-to-git'
Date: Fri, 09 May 2014 05:59:40 -0500
Message-ID: <536cb51c3f348_6b2dde7308b1@nysa.notmuch>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
 <1399597116-1851-26-git-send-email-felipe.contreras@gmail.com>
 <vpqr443i600.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Q8OpbGVzdGluIE1hdHRl?= <celestin.matte@ensimag.fr>,
	Benoit Person <benoit.person@ensimag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 12:59:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiiWq-0004zA-Ph
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 12:59:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858AbaEIK7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 06:59:45 -0400
Received: from mail-yh0-f45.google.com ([209.85.213.45]:56170 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbaEIK7o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 06:59:44 -0400
Received: by mail-yh0-f45.google.com with SMTP id b6so3514728yha.4
        for <git@vger.kernel.org>; Fri, 09 May 2014 03:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=2q+YPCHNIWxIr6njhRnAsVEUeex4bnuScuyNbdyl5+0=;
        b=vLmTeJB9aXRUhzMC17xJL9+fsHuG+mxpQmlGMeW8urvtXICDzRSGHQmvwo1r9BiW+3
         j+eN3AraKxYZgo5BtsHdLZu6SxRBY77jr38AsCJasvsoa7pX9+RyY49Pp5Dra+NdWsyB
         e9FBBv9CKY1oNWd/YBAqGUR6HmwJsMW4QOtMlqS+TqSOhaeAlXXZFaA7RIVy2k9moOLI
         qZUbZZUz1KC0yIIFB1xOKZNqHhTFj2W/zNYnE6upNLqg7QKzsi9L32gHeF3tB/hXUVK/
         my1MhCiC7E8Y8E+F39OzCCg7qzne9s75tpXznrjxX4xRA4moQyP+azWpFOIOWPw+oJ2q
         uGmg==
X-Received: by 10.236.190.72 with SMTP id d48mr13756672yhn.62.1399633183956;
        Fri, 09 May 2014 03:59:43 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id z63sm5661117yhh.11.2014.05.09.03.59.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 03:59:42 -0700 (PDT)
In-Reply-To: <vpqr443i600.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248551>

Matthieu Moy wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > No chance of ever graduating.
> 
> I see no relationship between the chance of graduating and the removal
> from contrib/.

Read contrib/README.

> If you want to remove mw-to-git from contrib, then a good starting point
> would be to explain why you want to do so in the commit message.

The purpose of the contrib area is to either a) give visibility to
otherwise potentially ignored scripts b) serve a staging area for
features before moving into the core.

This script doesn't match either of those. It doesn't belong in the
contrib/ area.

-- 
Felipe Contreras
