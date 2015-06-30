From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v6 6/7] git-reflog: add create and exists functions
Date: Tue, 30 Jun 2015 11:57:45 -0400
Organization: Twitter
Message-ID: <1435679865.30953.6.camel@twopensource.com>
References: <1435609076-8592-1-git-send-email-dturner@twopensource.com>
	 <1435609076-8592-7-git-send-email-dturner@twopensource.com>
	 <CAPig+cROJJNTcZnZfMP0meA8ZWGcSHcQCMTCkuC+kn_+OQZ-zA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 17:57:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9xv4-0007NS-Hm
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 17:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752556AbbF3P5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 11:57:50 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34200 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753446AbbF3P5s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 11:57:48 -0400
Received: by qkeo142 with SMTP id o142so9519574qke.1
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 08:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=ich3/wbfGG2XGM00mRy93fl8oCnHuOBOZtBYsq64Ymw=;
        b=IYAXN+UCYox/J9m0hziMY81YEaaW2SJQYkB8Jhv19py0ZhvsmMnn8t6FglIzcXnzE4
         l/EojkUnMvFyZafRT8iFQOZGpFYbwxLEAJg0uo0pizrhYLv5RjwTqpGagVFnEu7k43kw
         25kXyQ8vT4pF/hStdRjlSE7XdJ6P7uuUiWP+RpnlBF2m/e+JpVhGtKsuR/CwqU+nS6g8
         XJqsGdbTRMRo74xX6J+TFT2PCijwVMyoEkkxUou4FkUdoif4+vsqrxwK4fDbBC33mjv4
         mYeX0wDwPH1cyj6A/neUI1pcCEzGVL7ddWRaU3SsfryLzFxnFOW4XivSJfe/1wV7Npag
         Rygw==
X-Gm-Message-State: ALoCoQn/L+rQTKAwxPuxbiEHiZqm6uCL9Bt7F/gPN3u6GOqVHK25UQqUpSd2zDYZ+Sp/GrqJlprr
X-Received: by 10.140.135.6 with SMTP id 6mr28804927qhh.101.1435679867315;
        Tue, 30 Jun 2015 08:57:47 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by mx.google.com with ESMTPSA id k82sm100839qkh.48.2015.06.30.08.57.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jun 2015 08:57:46 -0700 (PDT)
In-Reply-To: <CAPig+cROJJNTcZnZfMP0meA8ZWGcSHcQCMTCkuC+kn_+OQZ-zA@mail.gmail.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273072>

On Tue, 2015-06-30 at 03:34 -0400, Eric Sunshine wrote:
> > +                       strbuf_release(&err);
> 
> This feels a bit dirty. While it's true that the current

Thanks.  New patchset pushed to the branch on github:

https://github.com/dturner-tw/git.git
dturner/pluggable-backends-preamble
