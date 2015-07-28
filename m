From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 3/5] pseudorefs: create and use pseudoref update and
 delete functions
Date: Mon, 27 Jul 2015 20:49:46 -0400
Organization: Twitter
Message-ID: <1438044586.18134.9.camel@twopensource.com>
References: <1438027720-23074-1-git-send-email-dturner@twopensource.com>
	 <1438027720-23074-4-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: mhagger@alum.mit.edu, sunshine@sunshineco.com, philipoakley@iee.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 02:49:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJt5c-0001x4-BP
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 02:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754890AbbG1Ats (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 20:49:48 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:35266 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754858AbbG1Atr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 20:49:47 -0400
Received: by qgii95 with SMTP id i95so64761281qgi.2
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 17:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=ON6dTmgStpawJtI0mr01ds8nukt/6SWmY2w9OE/Ubg8=;
        b=h+8h93QR6tgKAkPTlzEdi+ONt9Im6QfPQq5vnWTAA0uaebR17FmCBIk2bPgvcMFxI3
         KiFB8SwaPLOLz81iBccFbrC/vxu8Drc2QaSTd+ZjTGRw8ks7rcb3Ft/f0Exjcd9C+XHS
         +A/hOaePLzYJWBUGA5JmNY/VIleFva5iFInabBsQbhj1+yqY+L9M+kMqq7QzuDvW1uGQ
         CgsfiyEYlRzROkWfArVxS8KbHJcKBvkiuq+N5GcDQihcA2Lh0zUniJXFaXOyUQCgkDK3
         mfKdGpYw8Om3+rKGgUiNIIWNfmvc13X9yjo16P0iU0n/3Vki8mfoI9C1SWwZo4DGYVFM
         yyxg==
X-Gm-Message-State: ALoCoQk65ibpWHCIcp1eOEuY+hoKowQJKjHCO4gwpAYwHGZpIzePtDVGaNjOG62sJLPq/6mOzlS9
X-Received: by 10.140.152.213 with SMTP id 204mr19836298qhy.37.1438044587136;
        Mon, 27 Jul 2015 17:49:47 -0700 (PDT)
Received: from ubuntu ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id q18sm10306984qkh.35.2015.07.27.17.49.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jul 2015 17:49:46 -0700 (PDT)
In-Reply-To: <1438027720-23074-4-git-send-email-dturner@twopensource.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274723>

On Mon, 2015-07-27 at 16:08 -0400, David Turner wrote:
> +	if (is_pseudoref(refname) && 0) {

Whoa, that's not right.  Will fix that in the next re-roll.
