From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2 01/43] refs.c: create a public version of
 verify_refname_available
Date: Mon, 05 Oct 2015 16:23:04 -0400
Organization: Twitter
Message-ID: <1444076584.5158.12.camel@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
	 <1443477738-32023-2-git-send-email-dturner@twopensource.com>
	 <5611FCA4.9030809@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Oct 05 22:23:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjCHv-0001we-OO
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 22:23:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbbJEUXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 16:23:07 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34812 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbbJEUXG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 16:23:06 -0400
Received: by qkbi190 with SMTP id i190so53867977qkb.1
        for <git@vger.kernel.org>; Mon, 05 Oct 2015 13:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=GjWttdcIvb7OqiEwGw2RX8nFbHLbYYJNBQIBx6Uv/bw=;
        b=Iik4vuGLOZYkcWiWwS6OZSWGNVwA/LCwltFA2ya/o0b6wxYs1lRYFbM2A95lUDEFjd
         Ke7+oYz7PyZ1wBZatNyWhsk9cVICcOLg6zPJu4XbwCM6jehixjOaA8S5tlWTLR1xTLVn
         qPuQbBkQKJD03W2HkQJVaoPUIFgXTL23pj4BMxx/DOZ4Yun5BY1fjtb8mdgLVKsJgB46
         Te/u/VOaac++3pwlp7Ho4UHP1ySL5/RrgEokQkJuVAw5ODfXf8P2tipkB1Os9WH93Aeh
         LQm11gHX4Xc9ytPF9w62gcHXoDokNc0dzqOU2/Vi/Es4+Z413cSq4V9/yC6J27xQA/up
         AQWw==
X-Gm-Message-State: ALoCoQktlQfplhvglVZ1b8VbskRh900JRaUU5NpLV1Mpa0yiP7NHwjnicsbxIw/naoL3DBTg6RN8
X-Received: by 10.55.197.77 with SMTP id p74mr18742197qki.89.1444076585855;
        Mon, 05 Oct 2015 13:23:05 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id m136sm12033977qhb.37.2015.10.05.13.23.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2015 13:23:04 -0700 (PDT)
In-Reply-To: <5611FCA4.9030809@alum.mit.edu>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279077>

On Mon, 2015-10-05 at 06:29 +0200, Michael Haggerty wrote:
> + * skip must be sorted.
> > + */
> 
> This comment is approximately a copy of the comment for
> verify_refname_available_dir(). It seems unnecessary to keep both of
> them (and is also a small maintenance burden). I suggest you shorten 
> the
> comment at verify_refname_available_dir() and make it refer to the
> comment for this function for the details.

Will do, thanks.
