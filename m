From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 0/4] submodule config lookup API
Date: Mon, 15 Jun 2015 14:48:48 -0700
Message-ID: <xmqq8ubk7idb.fsf@gitster.dls.corp.google.com>
References: <cover.1434400625.git.hvoigt@hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, "W. Trevor King" <wking@tremily.us>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karsten Blees <karsten.blees@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Jun 15 23:49:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4cFU-00081J-9s
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 23:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753352AbbFOVsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 17:48:52 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:37836 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237AbbFOVsv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 17:48:51 -0400
Received: by igbsb11 with SMTP id sb11so1288140igb.0
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 14:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=eDGNer2rLVXMkCfJtIQZgQWrlLuoR9pRo+Un+6b9hm0=;
        b=N7/2/5sUJUaReKaDsIu1lZpBIshjL/W4q70yacW33uLz0xuYBT1UlvEBOpToedmOMT
         FFtPAmKxUoZKz3Y6gs7SZxdb/ViLaobFHo3GzV8b99e+RnlijLd639VMfLSYbzGE1uus
         fDx1K4Vcq1TBaJBBOI3o7926W+UXj0FhAz6vzAIoOEWT1l2v3dZZPl83Xj/BGG/vLiqm
         X7uKJyUliLROsAeXHM/Qp4KvBkWMYUpeSs+muBCt2zRD8YzzlJA8iTNRLeHZmO70lxsA
         lA2f6RlKhICSDWP/zcV8HF9P3RnLzmZTJs66e4DCdhdyENOhCTIzEAkR0AYf6c6+H9H5
         8W3Q==
X-Received: by 10.43.169.137 with SMTP id nm9mr31775069icc.82.1434404930668;
        Mon, 15 Jun 2015 14:48:50 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:16f:c4ab:c37f:75f8])
        by mx.google.com with ESMTPSA id rj5sm8470403igc.2.2015.06.15.14.48.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Jun 2015 14:48:49 -0700 (PDT)
In-Reply-To: <cover.1434400625.git.hvoigt@hvoigt.net> (Heiko Voigt's message
	of "Mon, 15 Jun 2015 23:06:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271736>

Thanks.  Will replace and wait for comments from others.
