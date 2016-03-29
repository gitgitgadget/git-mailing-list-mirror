From: Ori Avtalion <ori@avtalion.name>
Subject: Re: Warning about conflict markers - undocumented 'diff --check'
 feature & suggestion
Date: Tue, 29 Mar 2016 14:19:47 +0300
Message-ID: <CALgdb5+E7_CT2e9WFBd9GhiFuc_B7+bpC9tjDfR+-QiTGeoP+A@mail.gmail.com>
References: <CALgdb5JuoYpHAPxTY2cHdbkcPUjKtsWQ_DY5rBrw-YKCwj2yvw@mail.gmail.com>
	<xmqqd1qe1a2i.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 13:19:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akrgg-0008I2-L1
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 13:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752261AbcC2LTv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 07:19:51 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35236 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbcC2LTt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 07:19:49 -0400
Received: by mail-wm0-f41.google.com with SMTP id 191so46560701wmq.0
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 04:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=K8FuJM+/IJQ/+sokL2LsAeLP44UCCqNvpNpjbjDeYIc=;
        b=ddHAmAU7XMzCS8rnle56F21Dk9ndKIhzQNkAhOp8VRxc5ajZsJlfMCcuQ7uaCC8258
         4ubXtLAqK+vrVml/KkOhvtLy6hLBPYKk96gByz4T1FXkFJ3+mpn7U688e9bFUNL/Ch0Y
         nvVZnHTrGNtUCP8Vkx94U8NbZuS7ccB7D/r2YF7DibRH0+QYQ4rzl0ovE+l23j7Cheha
         kjO2TVVLAXDqjY+pNy5FIEUjajgR5Cm4kcWRmv4SNBcgsdONQEc76TOJTJNtnjIWVwp0
         hNPD/NDlfTboHlCfJyW3bTVWSVhnf/9jhzYquAIPJszE44FOcX/ypiRuUav5ghH+RCae
         kDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=K8FuJM+/IJQ/+sokL2LsAeLP44UCCqNvpNpjbjDeYIc=;
        b=Dz1teHEFnIwJ1HVmKdQot9qMF1eLbBeNb3juT6OtsHs2VVHLr5P2lYslx4abvPVSSM
         OBfT3fIlXOOvaGL3Hmcaw1g0eiQHGj7LWFmIggjIPwqbE+DxYjTu+uMiZx6N5Y4Pgu7Q
         DUk2o2zlHYYVZ226zZx3grWAAIbe5n85pWibajcpmVKGRtEhm7f/vVBHgQPihrwIEHbx
         ugwzQc8YXwQnL/G3NE4ZQ/8l3u19/pkGtDZ9ApuJP0+A9ywPK0KahHE+jiVt8cxJFlvY
         D8K+HBaruHtE4YXF03QpGVWaQKWdzz80V3jZHhhcLpz7UwPt/Fx5HNGRFMFytTbaZY7e
         NpMg==
X-Gm-Message-State: AD7BkJKIV//eSaSkbSj16aBK9qmPvpSJynAU1E7a7CIeA6ZcigyHo3RbwGMbYmsnOWM+3UV0P190mselFZylqg==
X-Received: by 10.194.92.107 with SMTP id cl11mr2337401wjb.21.1459250388006;
 Tue, 29 Mar 2016 04:19:48 -0700 (PDT)
Received: by 10.194.69.132 with HTTP; Tue, 29 Mar 2016 04:19:47 -0700 (PDT)
In-Reply-To: <xmqqd1qe1a2i.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: Ny8B8aJiOW5HWLNDs_BWiqen5Ik
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290117>

On Tue, Mar 29, 2016 at 2:01 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Ori Avtalion <ori@avtalion.name> writes:
>
> Thanks for digging (even though I do not think the message you
> quoted has much to do with this).

Oops, you are correct! I had several tabs open digging through the archives and
picked the wrong one :)

> Care to try a patch?

Yes. Will submit one soon.
If my change introduces a few words that exceed asciidoc's ~72-char line width,
should I reformat the entire paragraph? (thus making it had to identify what
changed exactly)

Any thoughts on adding similar functionality to "git add"?
