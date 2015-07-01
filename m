From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Add tests for wildcard "path vs ref" disambiguation
Date: Wed, 01 Jul 2015 09:31:30 -0700
Message-ID: <xmqqzj3falgd.fsf@gitster.dls.corp.google.com>
References: <1435668007-31231-1-git-send-email-pclouds@gmail.com>
	<1435748894-4636-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 18:31:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAKvE-00047I-E7
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 18:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbbGAQbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 12:31:35 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:33942 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184AbbGAQbd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 12:31:33 -0400
Received: by iebmu5 with SMTP id mu5so38300444ieb.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 09:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=nZ9mLuJ5e3q3IYkWx3v+D219yAxHO7oJLacnzH6QDJY=;
        b=wccEf5C7FwTDRoW05kOGjYmDjBrPFYUHeWMiwaRPb3W/eYDmmxjlSKLgclOZv8sNL4
         Zfi4UF5wQX7q559rT/ieu5vqUGOp1pBfL/Rulil/cRVliR1IZICyggL6HnL5D7dEuXP/
         5FjYBhGtvhBxYht1EoYo/posU4o2vjB6L8Ce7NjlMcjvNn8J2hPdNIjybzSGm3WaNu7R
         BfmZIKhH9CE/Z3FIASHvild6oEIN7456eJ9CPjF9E+CzysLCQSdcbP83RFtLxceT95pD
         OzkBpOjatxLjRTmmd90PGvuY70W+MGGTn1AMVWx1bNHTo9gQN33JFRnjk1+arsEhb5zZ
         KQTA==
X-Received: by 10.43.5.73 with SMTP id of9mr5519700icb.92.1435768292975;
        Wed, 01 Jul 2015 09:31:32 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:64b9:4225:baa1:c97c])
        by mx.google.com with ESMTPSA id e69sm1707177ioe.11.2015.07.01.09.31.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Jul 2015 09:31:32 -0700 (PDT)
In-Reply-To: <1435748894-4636-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 1 Jul
 2015 18:08:14 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273158>

Thanks, will queue.
