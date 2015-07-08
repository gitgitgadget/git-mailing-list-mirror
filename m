From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 8/8] git-stash: use update-ref --create-reflog instead of creating files
Date: Wed, 08 Jul 2015 00:28:41 -0700
Message-ID: <xmqqoajnyuom.fsf@gitster.dls.corp.google.com>
References: <1436316963-25520-1-git-send-email-dturner@twopensource.com>
	<1436316963-25520-8-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 09:28:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCjmm-0002B3-CO
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 09:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932622AbbGHH2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 03:28:47 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:36290 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932497AbbGHH2o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 03:28:44 -0400
Received: by iecvh10 with SMTP id vh10so150252437iec.3
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 00:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=7voKZVKKhMVHfA79lJGjVpiLb2r3vqDb6veesK9qUV4=;
        b=DgBWKMjdQtcfaqpaYSQphxkT3HuW4JCwJS+kKc+5jk3qHLb5C+VtB8mQHOANAEvCrt
         SzqVTWd9osK+6GhF0Bh+CBxZc7fyDElpnVhSMp9LlvKEr+GTUCFcp/q0mlxEQ36vq4Ks
         dxbYTS+y+GJAqofR1IE1B3o4bu2Eb7efLy/pHrc1DKPonWOpxA0kw3q2J/cIDONi8p4U
         HyPXHqpBHVSAuGRpdktTHo5Ubu6kuGSGe6Uuqv4dKK5UnR4tG66YPPw3+lysrhPWOLKQ
         M78zSCPJRgxTlPlmSq6B21CbMWG/LaG6/E7op5nIJQGbCPMzyc92I8GQ6YSFfPymIrH2
         Xh7Q==
X-Received: by 10.107.28.202 with SMTP id c193mr14590126ioc.90.1436340523456;
        Wed, 08 Jul 2015 00:28:43 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:7d74:6f43:1e30:fb1d])
        by smtp.gmail.com with ESMTPSA id y98sm1282488ioi.25.2015.07.08.00.28.42
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 08 Jul 2015 00:28:42 -0700 (PDT)
In-Reply-To: <1436316963-25520-8-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Tue, 7 Jul 2015 20:56:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273643>

David Turner <dturner@twopensource.com> writes:

> This is in support of alternate ref backends which don't necessarily
> store reflogs as files.
>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---

Thanks.  The last round was already a pleasant read, and I didn't
spot anything questionable in the interdiff between the last one and
this round (although I admit that I maybe a lot less careful at this
time of the day ;-).

Michael?
