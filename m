From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v17 16/48] refs.c: add an err argument to delete_ref_loose
Date: Tue, 17 Jun 2014 08:55:06 -0700
Message-ID: <CAL=YDWmGkPMYT8vFYxGa7z3wAwEPMqDy7S8cx4s=9c1DhV9VqQ@mail.gmail.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
	<1402941859-29354-17-git-send-email-sahlberg@google.com>
	<xmqqd2e8o05p.fsf@gitster.dls.corp.google.com>
	<CAL=YDWmHg8b0qGqWjSy+0mT20mGgbADnteNKzd5A6OC-VUrsUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 17:55:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwvj9-0004jW-UG
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933473AbaFQPzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:55:08 -0400
Received: from mail-vc0-f177.google.com ([209.85.220.177]:37641 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933464AbaFQPzG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:55:06 -0400
Received: by mail-vc0-f177.google.com with SMTP id ij19so6511553vcb.36
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=f6DcFRnLZsmBzcOtqknpQZEMLV8HCTeQLlFAeZP3ngw=;
        b=DD3FY7V8Xh3u9Ko18uE9U9zZTPV19VnD7tuXaDNgkhlcDluj2vRg5uCJ2/xkDDBBY0
         3bjIFxIcsMNE1dtu828UeYwYTLmbErxQnFFDE+qshTS4Gw+UCcarjGR1WCeWK7mFQ9fW
         qS7ZHbb183GSTHnaYaAbZwoCub99Wehkxc0hEO2jNxpzP2G70EROdXN3t7jrs1TzcAkn
         N6yii6CPFB2y9krv0XFWvaD6FxZp4Wu3uIpD4QKaga1boeIwJEQGx27uUNJXT3veYhBK
         GnK84NwUlr5VLcm6OLjfGt9LghfTsTvNrZbAspVrgxR/ky5OioR/y55Zp+stR+1ZoG+C
         ApjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=f6DcFRnLZsmBzcOtqknpQZEMLV8HCTeQLlFAeZP3ngw=;
        b=MrpkmsH/k41/FwLt+hpRP6vXt1jrJnlx+6XJMhUU+EJ9QpREI1QZAtbC9ZWRxtVf8x
         qdvdBB+I21Ezu5qJX1arYl6XgIPJ76ee8gorCPSveo3HZo2Nlno5ma2+JQAsKeqESQE7
         upKuZExOcpT48LDEbQDP1Z3mYXLrccy+6pGvNvxjVHnbbeQvtBDGdnxbmbYFxEafLmFY
         TOuFly3Nb87tZkINNUrNKX613v9hfcuXHv4SaCwUgRpeDpwrSOXhpMSeJYO5qCf87btE
         G2D6isaB2379xPTbDnfUFUbnJKrbQr07YrrgixIWKw4pTR3azpVvYekWhFl7FIRPtcki
         QBqA==
X-Gm-Message-State: ALoCoQnMfH+hB3sffYcRC+kXuUTK/nj5XGIf+6Nws04wLOxbazGCdiBHRCV9Mib9xyonf2yXOsYA
X-Received: by 10.58.23.7 with SMTP id i7mr1134361vef.57.1403020506124; Tue,
 17 Jun 2014 08:55:06 -0700 (PDT)
Received: by 10.52.255.65 with HTTP; Tue, 17 Jun 2014 08:55:06 -0700 (PDT)
In-Reply-To: <CAL=YDWmHg8b0qGqWjSy+0mT20mGgbADnteNKzd5A6OC-VUrsUA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251890>

Thanks.

I have rebased it on current master and re-sent it as v18

I passes all tests, except t0008 which is unrelated to this series.

regards
ronnie sahlberg


On Tue, Jun 17, 2014 at 7:34 AM, Ronnie Sahlberg <sahlberg@google.com> wrote:
> Let me redo it so it applies to current master.
>
> On Mon, Jun 16, 2014 at 5:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> The series applies cleanly up to 25/48 or so to 'master', but this
>> step already breaks tests, at least t1400 but possibly others.
>>
>> Please do not make me bisect X-<.
>>
>> Thanks.
