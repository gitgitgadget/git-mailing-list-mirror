From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 00/10] mark private symbols static
Date: Wed, 14 Jan 2015 16:07:34 -0800
Message-ID: <CAGZ79kZbMPKg0ML9Megnpa3UfADdd5UkQOCLn+oFf+W41q2n2Q@mail.gmail.com>
References: <1421278855-8126-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 01:07:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBXyO-0005yd-Lp
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 01:07:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576AbbAOAHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 19:07:36 -0500
Received: from mail-ig0-f173.google.com ([209.85.213.173]:34073 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008AbbAOAHf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 19:07:35 -0500
Received: by mail-ig0-f173.google.com with SMTP id r10so12269699igi.0
        for <git@vger.kernel.org>; Wed, 14 Jan 2015 16:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IutU9tBAEOKqNUsl3wPh8fuNb+KqEge6qrVqxBIbZ4w=;
        b=TlPQKiGobuRI9uoHiiWKhtxqKxjuTL+UGwjZeNL3TTrQLZIjg97WFf7E0OLSg2nUZ6
         la2/CCGS+5dll1syGT1uE0cte4q2DIOprvTFpRTw/FixPx/OHSOUnVWOdqV29zCYk5zP
         44UcA63H9NdxH9lQGapLH33fByzt+q/PSqmMuErKKpjbhtTHxeH757og9dwJO0hzvYb2
         MnUaCG83EK5oatyuSCJ2N2/B9Ct19/NrdWSkhaSR6fPu4+7YywLgeJUGvdv2axpZWDoz
         gqImV9sJ9iCpVpEltwdNdX+OC2PSb9kueSZnLqdCuQtfaX+lzhD1yIa8NfliGUHmrxj6
         Um8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=IutU9tBAEOKqNUsl3wPh8fuNb+KqEge6qrVqxBIbZ4w=;
        b=PQFkzfZJtS4FcsbYSVj16U8s3ORO1WGl8VGlC7EtFrR9O8B+N/zwzlDB4m84yPvElc
         CXjMvxKsUMmXGzCEkrUT/qdq3uhLBKGm7Sq6ho4rrY4G5XguE6qo/iIDll2MlZXL1DdS
         LHh1MQXJRxoxc+pcCx35TiSIieSboh9+vLjQgE6DyoDms7I3LGNOxeVwRxq3t0tfC3/w
         pIUy1qJZ/zBhlzUQTJG6qXQ7mgGL99YaJLfAvTN87f+C28KZNc/I4ZLOmAGwKw9vVW/j
         xg2skQXcsEx05fu/jAcKtEtGzyRFJs9K93kexpPsr7NWIlAim4Ol+QAS/az97p/Weuvq
         u2eg==
X-Gm-Message-State: ALoCoQlZYU4rWgEQB4S9CnHeppeSKUznbqH/cCpnHcT1uvUcY9roRX8um90JCevFNI7zUBD+dCBA
X-Received: by 10.50.117.68 with SMTP id kc4mr7477552igb.25.1421280454592;
 Wed, 14 Jan 2015 16:07:34 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Wed, 14 Jan 2015 16:07:34 -0800 (PST)
In-Reply-To: <1421278855-8126-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262451>

Regarding patch 1 - 9:
Reviewed-by: Stefan Beller <sbeller@google.com>
for what it's worth.
