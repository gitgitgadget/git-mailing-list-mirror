From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 0/5] Improving performance of git clean
Date: Mon, 15 Jun 2015 13:16:34 -0700
Message-ID: <xmqqtwu87mn1.fsf@gitster.dls.corp.google.com>
References: <1434397195-1823-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Erik =?utf-8?Q?Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 22:16:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4aoP-0005rb-Mi
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 22:16:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755985AbbFOUQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 16:16:42 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:35116 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755944AbbFOUQh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 16:16:37 -0400
Received: by igbzc4 with SMTP id zc4so63485562igb.0
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 13:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=/xkiczQ21EIoI/o7cAyoX34ruWOZECr6nBOII8UWx44=;
        b=zLcNIiOShNgpLOmrM7AIPJK8blK//bgubyrij7Jv4ClV74fvibSa2nnaq55ap17mnX
         +YbNTiFnw6a1MiFXWOjiUuRGsoX5TuwTgIiqImUbylTgaDfeEQOq0VChk8IotuJm5X7x
         3yX/VxqwD4VBu58g6rsU4yzOOxa0KXD3Q35lBbuqRO3vY2C77iDAa5y3JlJVecElnmLV
         KQDpbPopjBZF2ojUMCbbipPe24uUVqYFNPte9hPKVejzUJDHQIzlnhBD8M7LG+M3s3aH
         639/gd68qrJQbUFn2I967k2bwFkpooVRZQ88LcMCxuiwDEs3oPjLZVuq5QenX5/fKA24
         Dbpw==
X-Received: by 10.107.3.83 with SMTP id 80mr8863332iod.33.1434399396782;
        Mon, 15 Jun 2015 13:16:36 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:16f:c4ab:c37f:75f8])
        by mx.google.com with ESMTPSA id a82sm9541203ioe.22.2015.06.15.13.16.35
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Jun 2015 13:16:36 -0700 (PDT)
In-Reply-To: <1434397195-1823-1-git-send-email-erik.elfstrom@gmail.com>
 ("Erik
	=?utf-8?Q?Elfstr=C3=B6m=22's?= message of "Mon, 15 Jun 2015 21:39:50
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271722>

Thanks, both.  Let's advance this one to 'next' soonish.
