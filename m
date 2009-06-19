From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: visualise the output of git-diff?
Date: Fri, 19 Jun 2009 10:52:08 +0300
Message-ID: <87r5xgpsnr.fsf@iki.fi>
References: <200906190732.24455.Karlis.Repsons@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?K=C4=81rlis_Repsons?= <karlis.repsons@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 09:52:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHYtY-0002ZS-3q
	for gcvg-git-2@gmane.org; Fri, 19 Jun 2009 09:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755158AbZFSHwJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Jun 2009 03:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751574AbZFSHwI
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jun 2009 03:52:08 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:39369 "EHLO kirsi1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755070AbZFSHwH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2009 03:52:07 -0400
Received: from mithlond.arda.local (80.220.180.181) by kirsi1.inet.fi (8.5.014)
        id 49F6055A01F415A9; Fri, 19 Jun 2009 10:52:08 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1MHYtM-0001HM-2j; Fri, 19 Jun 2009 10:52:08 +0300
In-Reply-To: <200906190732.24455.Karlis.Repsons@gmail.com> (=?utf-8?Q?=22K?=
 =?utf-8?Q?=C4=81rlis?= Repsons"'s
	message of "Fri, 19 Jun 2009 07:32:15 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.94 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121886>

On 2009-06-19 07:32 (UTC), K=C4=81rlis Repsons wrote:

> this is about displaying git-diff results: in case of long text lines=
,
> where only a single word may be changed, it would be useful, if that
> single difference would be displayed in a different colour, but is it
> possible?

At least there is "git diff --color-words" but it may not be what you
want.

> And about pager - are you people all using less or there are also som=
e
> non-console viewers available?

I mostly use "less" but sometimes also "kompare" which is excellent:

    git diff | kompare -
