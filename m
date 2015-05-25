From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/1] send-email: Add sendmail email aliases format
Date: Mon, 25 May 2015 14:35:23 -0700
Message-ID: <xmqqtwv09w84.fsf@gitster.dls.corp.google.com>
References: <49e9a95b52aa61ed4f37edf1dfa178186acb4a29.1432367540.git.allenbh@gmail.com>
	<xmqqfv6nchmf.fsf@gitster.dls.corp.google.com>
	<xmqq382ncgmb.fsf@gitster.dls.corp.google.com>
	<CAJ80savVjb3_iKhNWPjQNK72DL7eq5YkbjWWG-1Gkx5+LOjzeg@mail.gmail.com>
	<CAJ80sas_D-6z4MvuFvvjoX7U_bM6b3brCo4rvYFCUfTmKS=6bA@mail.gmail.com>
	<xmqqpp5obotk.fsf@gitster.dls.corp.google.com>
	<xmqq1ti4bbu0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Allen Hubbe <allenbh@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 25 23:35:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yx01y-0007oe-RF
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 23:35:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbbEYVf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 17:35:26 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:35215 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050AbbEYVfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2015 17:35:25 -0400
Received: by igbyr2 with SMTP id yr2so44036372igb.0
        for <git@vger.kernel.org>; Mon, 25 May 2015 14:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=zw5rhEa6x36wWUu0V0pvhxA+MWTuXtXzDmFbuo9sfyc=;
        b=qIuXTOTW+QazDQmO4eIbZxqJJAe6bH2X8YntML6ICmY34fFiw2xGnytgLvmnXVgfB+
         c58b03oGER9i7YGx8OqpQghNoAejT0UXWzD7KPvDKX5YPmtSr9C5i2CY+sEVk852/Dxz
         XR/Swe40KSPkI4UmV6cUkG4+cEmHQ6IkM5/1NXwAytaj9jczc69SuZ1xBcvr5sae4jAO
         mVV9MCA13E/C6GZLC3RtcLo6Z8AkIY6WWVJ0VOTPyZXUU+mYOS/QhksMpZ2DjmUoAsqa
         UbG9nl8NTiUdwX/AwDMbYHVIHAVDsmS2hPgrOn3cBGOp/TzMWQOb2PczyUaB35m0PvTs
         c+Gg==
X-Received: by 10.50.114.70 with SMTP id je6mr25625692igb.43.1432589725135;
        Mon, 25 May 2015 14:35:25 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:f93e:abc0:fe54:4a5a])
        by mx.google.com with ESMTPSA id av6sm6881682igc.17.2015.05.25.14.35.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 May 2015 14:35:24 -0700 (PDT)
In-Reply-To: <xmqq1ti4bbu0.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 25 May 2015 14:12:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269911>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
> FYI, I have tentatively queued this on top of your patch.  Please
> see "git log master..cf954075" to double check.

Sorry but I had a typo there...

>  	git format-patch -1 -o outdir &&
> -	cat >>~/.tmp-email-aliases <<-\EOF &&
> +	cat >>./.tmp-email-aliases" <<-\EOF &&

This should just be

	cat >>.tmp-email-aliases <<-\EOF &&
