From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/7] submodule: Allow errornous values for the fetchrecursesubmodules option
Date: Wed, 19 Aug 2015 11:09:38 -0700
Message-ID: <xmqqtwrv9ml9.fsf@gitster.dls.corp.google.com>
References: <1439857323-21048-1-git-send-email-sbeller@google.com>
	<1439857323-21048-5-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, hvoigt@hvoigt.net
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 20:09:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS7o0-00063o-Ok
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 20:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbbHSSJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 14:09:40 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:34998 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438AbbHSSJk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 14:09:40 -0400
Received: by pdob1 with SMTP id b1so4142478pdo.2
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 11:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=VjHwipBkzw+TVi07UtEcPfODFJ3GI3A9L3sGNqlmQfg=;
        b=bvqP4/yHjwBAAmFn1rmmevGPuFFWW0GXUB/ER85YRQU38N5tLNvoUe7hur/LN06P3O
         DICIwx4tAi2LMRQ2tKOK9zLaqUWhfbO+a9RJbbq2Dk1FQv2M/II6XM8QgTC7uaVuL3ns
         YdqjdyXlbdIDSM+R6qAGTQZlZzoxRbg/5bycRFH75yObqEb8bJG+jYixLEqFW995l/8c
         f9BHRexKWfj6M63q023sAYHAYhGds7XmQtWTsGWbZ/8eUB8Nnj2+Hov3Rp4yIiOYCNzF
         w2H0lN5tpfxsMFlQpQVSO6OXFNCFbCKXuF/7e+LOPMWcM5YM3sYXtzcKqg6zMp731rN0
         DDMg==
X-Received: by 10.70.54.165 with SMTP id k5mr27522546pdp.138.1440007779723;
        Wed, 19 Aug 2015 11:09:39 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a5d7:91a5:eac5:b635])
        by smtp.gmail.com with ESMTPSA id vx9sm1620660pab.21.2015.08.19.11.09.38
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 19 Aug 2015 11:09:39 -0700 (PDT)
In-Reply-To: <1439857323-21048-5-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 17 Aug 2015 17:22:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276208>

Stefan Beller <sbeller@google.com> writes:

> From: Heiko Voigt <hvoigt@hvoigt.net>
>
> We should not die when reading the submodule config cache since the user
> might not be able to get out of that situation when the configuration is
> part of the history.
>
> We should handle this condition later when the value is about to be
> used.
>
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

The retitle is good but we'd need to typofix erroneous there, I
think (will do so while queuing, no need to resend).
