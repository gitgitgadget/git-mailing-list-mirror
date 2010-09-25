From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH/RFC] rev-parse: stop interpreting flags as options to
 rev-parse once --flags is specified
Date: Sat, 25 Sep 2010 17:19:45 +1000
Message-ID: <AANLkTi=8gv5arpdOVGHvf7sjNd==G=a4HoBBTbizq=OK@mail.gmail.com>
References: <robbat2-20100924T191752-102740530Z@orbis-terrarum.net>
	<1285399156-21792-1-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jon Seymour <jon.seymour@gmail.com>
To: robbat2@gentoo.org, casey@nrlssc.navy.mil, git@vger.kernel.org,
	brian@gernhardtsoftware.com
X-From: git-owner@vger.kernel.org Sat Sep 25 09:19:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzP32-0005Lx-4S
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 09:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752870Ab0IYHTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 03:19:47 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:41427 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472Ab0IYHTq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 03:19:46 -0400
Received: by qyk33 with SMTP id 33so5032750qyk.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 00:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=jnjnuE06s/j4yvewkl518ZJUTx/9Q2ny1NgyTMRTTLM=;
        b=MNO9+qMXJQ2lZJmdlhu6p6wdzqeqxFfjQEisUGyjWT0dGGj0W3Kf9MGU5Xeobf4hCx
         ehUWRn/scgm4nWp4gNT6ZNzhHEhCUKBMDZ5ta/LovdlqwjX1ayVzU5ymJudctFr3BOw+
         4v4XT/l5X2dc0K4ADBq6RQyg4esogKF/VSCcI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=aflilXres3WGI4tfU8ysJdWjbc4Es64xM7ZWeje16QWthyAOK01rf+RLTWkn/qQPY3
         ejHNIhHVU058DVZghMb5zCP12eCRHEoxv8wf3XeAq2nCBTPDDkZCqMw/4+AYasfQnp/H
         MQYPX4BzIZzl9hbxZfCMjStSnVWEC2WpbbfKk=
Received: by 10.229.88.10 with SMTP id y10mr3359354qcl.144.1285399185899; Sat,
 25 Sep 2010 00:19:45 -0700 (PDT)
Received: by 10.229.219.196 with HTTP; Sat, 25 Sep 2010 00:19:45 -0700 (PDT)
In-Reply-To: <1285399156-21792-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157127>

On Sat, Sep 25, 2010 at 5:19 PM, Jon Seymour <jon.seymour@gmail.com> wrote:
> Current git rev-parse behaviour makes --flags hard to use if the remaining
> ...

Note that I haven't run the test suite yet to see if it breaks
anything. I'd also
expect to write additional tests and update the documentation.

jon.
