From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/8] object_id part 2
Date: Wed, 10 Jun 2015 17:21:33 -0700
Message-ID: <xmqqpp53gkmq.fsf@gitster.dls.corp.google.com>
References: <1433867316-663554-1-git-send-email-sandals@crustytoothpaste.net>
	<xmqq381zi3ev.fsf@gitster.dls.corp.google.com>
	<20150610235114.GA786544@vauxhall.crustytoothpaste.net>
	<20150611000251.GB786544@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eQ==?= =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?= Duy 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Thu Jun 11 02:21:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2qFZ-000434-QG
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 02:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663AbbFKAVi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 20:21:38 -0400
Received: from mail-ie0-f195.google.com ([209.85.223.195]:33283 "EHLO
	mail-ie0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbbFKAVh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 20:21:37 -0400
Received: by ierx19 with SMTP id x19so8021940ier.0
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 17:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=o2kvzyq6tnA97jlYM4dtN6BJXqVjNR48Ak77G2bpKxE=;
        b=vMIZPgo7TFgukfn0++T6ti6+7gDypP+AIg46RgN9CqeX8ga1GQ+cmhd9BSTFEuJfCS
         iC0+LNubPbndj1Z/3bj2QufgFlVgUlTzAk1VBrreXRhyFAdRS82fPAAIlQRCIh+fzSOe
         YnY1Z9GZjqDqskZ54WSjvnfQuxfPqV0emfOEur+6eEfEPKMsjkvztWN5X5bRAJfpY1OT
         IjiRCEQ6OY5A0BKh2xXtVwVkfva2bj614DTzZ19lPt4yNhlAWAsVIz42uv5HE3BV1bcm
         QyU+70y8XHYYiRpThWAa8Bgg7DDDFcMAowzljJsYULfmx5ilDYV7et/VDn5nmMFvnumm
         SxTQ==
X-Received: by 10.42.214.79 with SMTP id gz15mr7656015icb.86.1433982096283;
        Wed, 10 Jun 2015 17:21:36 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:683f:a599:6eb8:1b1d])
        by mx.google.com with ESMTPSA id 140sm7067920ion.16.2015.06.10.17.21.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Jun 2015 17:21:34 -0700 (PDT)
In-Reply-To: <20150611000251.GB786544@vauxhall.crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 11 Jun 2015 00:02:52 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271370>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Wed, Jun 10, 2015 at 11:51:14PM +0000, brian m. carlson wrote:
>> On Wed, Jun 10, 2015 at 03:50:32PM -0700, Junio C Hamano wrote:
>> > "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>> > >   Convert struct object to object_id
>> > 
>> > It seems that the last one didn't make it...
>> 
>> It appears the mail was too large for vger.  Unfortunately for
>> bisectability reasons, it is necessarily large.  I'll resubmit the patch
>> with less context.
>
> Unfortunately, the only patch I can generate that falls under to 100 KB
> limit is with -U0, which isn't very useful.  How do you want to proceed?
> The branch is available at [0], or I can send the -U0 patch, or I can
> split it into unbisectable pieces.
>
> [0] https://github.com/bk2204/git.git object-id-part2

No approach other than just letting reviewers fetch from there and
taking a look is reasonable, I would think.

Did you create this manually, or is it a mechanical scripted rewrite
followed by manual clean-up?  If the latter, it may help people by
posting the mechanical recipe _and_ a patch that shows the manual
clean-up.  That is something we can reasonably review and discuss.
