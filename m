From: David Turner <dturner@twopensource.com>
Subject: Re: [RFC] On watchman support
Date: Wed, 19 Nov 2014 11:43:45 -0500
Organization: Twitter
Message-ID: <1416415425.14486.1.camel@leckie>
References: <20141111124901.GA6011@lanh> <1416270336.13653.23.camel@leckie>
	 <CAHVLzcnb6_rYPqKNFvnqrnwuToCeRp8NPY31Y-cbOEyY=wYvvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 17:43:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xr8MD-0001d9-9y
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 17:43:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755395AbaKSQns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 11:43:48 -0500
Received: from mail-qc0-f177.google.com ([209.85.216.177]:61642 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754398AbaKSQns (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 11:43:48 -0500
Received: by mail-qc0-f177.google.com with SMTP id x3so699438qcv.22
        for <git@vger.kernel.org>; Wed, 19 Nov 2014 08:43:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=0E/uXo6Eqq02PBLdGh6j+vaH3ny4h73NRazgmclW+A0=;
        b=krn8yCbdp38EY8hH7RPLry7t1B51l33vIxhHQQTZDbsXGc3CUg4L5ngWZOH+sBh/6v
         uHZjaz2U+lp6i7vWF6H72qY3+Rt+8ExbeGQ6koLm8ns5kYR8ZQShneddJgGthlVZPqOg
         uvjY8H6B1LleFIRZ7hivDE+P5zfL2sq/S5IN54GVFDantjg5QaajOgsHNpz1UmZwcLL2
         VWktBgnKL+uTuk7angJ+n2sVvv3j4zGn/w9ngDhh4tZkFtyW1fMHXV3QGoRuco3WoU1+
         er9352QSp9F6W+00Ln2uLT8yOC3vw3FjyVS7NDpxU90ldT3zj8+nuDozW/6nDesF3oce
         zm5w==
X-Gm-Message-State: ALoCoQkvrMk2yK7uMVb+8HgnyfPOO5ME96djHyiKo7IIU0Zg7Pdacuz1wWyU9e8neR3Hfb6j0CbG
X-Received: by 10.224.88.193 with SMTP id b1mr53592736qam.30.1416415427154;
        Wed, 19 Nov 2014 08:43:47 -0800 (PST)
Received: from [172.17.131.24] (ip-66-9-26-66.autorev.intellispace.net. [66.9.26.66])
        by mx.google.com with ESMTPSA id e2sm1793063qaw.10.2014.11.19.08.43.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Nov 2014 08:43:46 -0800 (PST)
In-Reply-To: <CAHVLzcnb6_rYPqKNFvnqrnwuToCeRp8NPY31Y-cbOEyY=wYvvg@mail.gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2014-11-19 at 16:26 +0100, Paolo Ciarrocchi wrote:
> On Tue, Nov 18, 2014 at 1:25 AM, David Turner <dturner@twopensource.com> wrote:
> >
> > My patches are not the world's most beautiful, but they do work.
> 
> Out of curiosity: do you run the patches at twitter?

An increasing number of us do, yes. 
