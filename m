From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Documentation on git-checkout --ours/--theirs improved
Date: Wed, 17 Jun 2015 08:10:02 -0700
Message-ID: <xmqqwpz24bhx.fsf@gitster.dls.corp.google.com>
References: <xmqqwpzafe88.fsf@gitster.dls.corp.google.com>
	<1434372447-51230-1-git-send-email-simon.eu@gmail.com>
	<1434372447-51230-3-git-send-email-simon.eu@gmail.com>
	<xmqq381s91gz.fsf@gitster.dls.corp.google.com>
	<CAO8d5Bbi8LHHP0nnYwv=_Qr6KZCJmFPTq5ut2KzeSKJ-i0RZNg@mail.gmail.com>
	<xmqqzj3z64q9.fsf@gitster.dls.corp.google.com>
	<CAO8d5BYkgNgB+fV2HjrUasYi0jz9YvZGuFxKNMBbWoaONpAeUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Simon Eugster <simon.eu@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 17:10:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Eyh-0002lw-Od
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 17:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbbFQPKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 11:10:07 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:37971 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755410AbbFQPKF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 11:10:05 -0400
Received: by igblz2 with SMTP id lz2so38967211igb.1
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 08:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=gExe6eRzhAEwEhTEAG7nFlogRu80yxTSV2IR3TN2jx4=;
        b=xTaAFJZtkcM9fv3RU3ZlJZoGUWsI8p2U8a/NJkwVaOQ/oMcZgz/sb+HaFWCWQDLmWN
         ru3OYCCuL9TAy8HD2WTmtlD+R5H6q7TNELtZoaQ5Hri8jViUxfnKIrgP5sAVf+0hTvY3
         udCJpIJDm3fWIlQfi2CTLuaLzZWWkaOyBDnoO3Xxrz0Xst/4rQfGdc4+ywQsv/ujSVwZ
         lUBhNJFQiE+y2kBwmOZK7Jr6uE+evScUHsn0e+l7v7tLdpoyu22Yr1GFp4igtLjXL8p3
         iUd+e/ZJEZcLsqQMgJ0wZ9fy4MK09vsls/QWvaoZYEKyTqNAa8BIl4fXywZxPmzOW+DW
         NVjg==
X-Received: by 10.50.108.102 with SMTP id hj6mr11796027igb.39.1434553805040;
        Wed, 17 Jun 2015 08:10:05 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a4d4:8fab:953e:ec65])
        by mx.google.com with ESMTPSA id t7sm12089622ign.8.2015.06.17.08.10.03
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jun 2015 08:10:03 -0700 (PDT)
In-Reply-To: <CAO8d5BYkgNgB+fV2HjrUasYi0jz9YvZGuFxKNMBbWoaONpAeUA@mail.gmail.com>
	(Simon Eugster's message of "Wed, 17 Jun 2015 16:31:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271853>

Simon Eugster <simon.eu@gmail.com> writes:

> A better picture would be nice.
> And regarding the textual description, are you going to commit your version?

Nah, I'd rather not take credit away from you ;-)
