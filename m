From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv1] git p4: fix for submit/edit unit test
Date: Wed, 25 Apr 2012 08:18:58 -0700
Message-ID: <xmqq4ns7et5p.fsf@junio.mtv.corp.google.com>
References: <1335341814-1598-1-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed Apr 25 17:19:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SN3zm-00081Q-3J
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 17:19:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753968Ab2DYPTA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Apr 2012 11:19:00 -0400
Received: from mail-vx0-f202.google.com ([209.85.220.202]:47427 "EHLO
	mail-vx0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513Ab2DYPS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2012 11:18:59 -0400
Received: by vcbfk26 with SMTP id fk26so23192vcb.1
        for <git@vger.kernel.org>; Wed, 25 Apr 2012 08:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=fyYppAGHE/bTYX8vBFoYBlOBklRAhtmgraVGE202Y10=;
        b=hsPvvov8UBOIgoSetb3Ge69vWdwbGmf2JHHAii5aQGX05xnckTDXdl68GSqoI1/LZr
         16PG3Se5B/pEQRXUtCA6zKVLczGaI6T7OHKl1W5+sGUJv1TJTO+mmEag4DhSa3RQ5jMk
         0jxpfCx4cCi2SRHc7iGlqzm3Po9VOxpxiVgf+bSoiXQ0xqmPdGtzYKft4KX7OfVLUyUU
         X8NTkRFvhLRu1pSclecELiClokohPqVBXXxPgXMmFVXA0f9k5iwr9hNoVt2pyg60ydNh
         hfdFUbl9WrK6Orq6N2hspax8qjHwETIkWJZ67kEN2tbUJ95M3k7iQqStkhr/IRQSiBcz
         pcKA==
Received: by 10.236.189.9 with SMTP id b9mr3633855yhn.8.1335367138966;
        Wed, 25 Apr 2012 08:18:58 -0700 (PDT)
Received: by 10.236.189.9 with SMTP id b9mr3633832yhn.8.1335367138873;
        Wed, 25 Apr 2012 08:18:58 -0700 (PDT)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id j51si21917789yhi.1.2012.04.25.08.18.58
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 25 Apr 2012 08:18:58 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id BF9711E005A;
	Wed, 25 Apr 2012 08:18:58 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 7FD95E125C; Wed, 25 Apr 2012 08:18:58 -0700 (PDT)
In-Reply-To: <1335341814-1598-1-git-send-email-luke@diamand.org> (Luke
	Diamand's message of "Wed, 25 Apr 2012 09:16:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQkTpiG05wpMkGXNLZNrD//aD3n/F/Futyewnp4npEocM/MXJVGvViwuH04CaQDbZCEjhJKf/O4/pjBHhUbc4AFBIKy7xiniBrwQzXiA3htCEu5TQrn8sO9QZIz8+o7TH1vwP2yQ7aIcqx5Qf4ZoPo8PQN45VcPO109L2M3dB5VFJ3jNWGE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196317>

Luke Diamand <luke@diamand.org> writes:

> My P4EDITOR changes broke the submit/edit "git p4" unit test.
> This fixes it.
>
> Junio - would you prefer me to resubmit the entire series?

It is too late for replacement, as the series is in 'next'.  Incremental
updates like you did is good.

Thanks.
