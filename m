From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v17 06/14] ref-filter: implement an `align` atom
Date: Thu, 10 Sep 2015 09:59:22 -0700
Message-ID: <xmqqy4ge43dh.fsf@gitster.mtv.corp.google.com>
References: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
	<1441900110-4015-7-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 18:59:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za5C5-0006nI-IK
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 18:59:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829AbbIJQ7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 12:59:25 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34424 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbbIJQ7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 12:59:24 -0400
Received: by padhy16 with SMTP id hy16so48042356pad.1
        for <git@vger.kernel.org>; Thu, 10 Sep 2015 09:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=4/bIfVbI4X/D32ECMXA5xpE4PwN3mTCErX/mNrS+hlE=;
        b=XtJunMNMTsv1KmKrlYPr3+A1soa2hdiSyHL/GUCPqA/3PQCoun0gR5TXGNxi3bureG
         k6m8i2IdI0Gp6lHQI2iDkzeei6NN26dQcy5JcSM07wzU0qgTHFEnuN+NYZffx8i3jz8x
         bCJzx8T84QLUHSC8Di7qtG9zQgEvGzszKBYq3paXVJkbiB4OiKV920qc/NbjnVgTTthJ
         uk4woIbFAZ4FdTVei2rM7qHu90vmaYQorHRhDJca6Nrx8CRK5xZWArrNQ6yLe77eVpqI
         0hM74H+TkNBgbCJtRlqm7YrmvQq8/3lFTSQuQW/MkHmAzAj0l3/u7stXRMtB8bpulDGZ
         ED5A==
X-Received: by 10.68.206.103 with SMTP id ln7mr83936175pbc.37.1441904364096;
        Thu, 10 Sep 2015 09:59:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:8419:5a5:3940:dfa0])
        by smtp.gmail.com with ESMTPSA id ob4sm13035892pbb.40.2015.09.10.09.59.23
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Thu, 10 Sep 2015 09:59:23 -0700 (PDT)
In-Reply-To: <1441900110-4015-7-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Thu, 10 Sep 2015 21:18:22 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277606>

Karthik Nayak <karthik.188@gmail.com> writes:

> Implement an `align` atom which left-, middle-, or right-aligns the
> content between %(align:...) and %(end).

Nicely done.
