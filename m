From: =?ISO-8859-1?Q?=22Peter_Valdemar_M=F8rch_=28Lists=29=22?= 
	<4ux6as402@sneakemail.com>
Subject: Re: Re* git diff/log --check exitcode and PAGER environment variable
Date: Fri, 08 Aug 2008 13:02:53 +0200
Message-ID: <489C27DD.90603@sneakemail.com>
References: <489C145B.5090400@sneakemail.com> <7vfxpfet8a.fsf@gitster.siamese.dyndns.org> <7v1w0zersg.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 13:04:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRPlH-0006Sr-Hi
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 13:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546AbYHHLC4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Aug 2008 07:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754282AbYHHLC4
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 07:02:56 -0400
Received: from morch.com ([193.58.255.207]:47755 "EHLO morch.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754065AbYHHLC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 07:02:56 -0400
Received: from [192.168.1.214] (ANice-157-1-71-161.w90-36.abo.wanadoo.fr [90.36.206.161])
	by morch.com (Postfix) with ESMTP id 3BFEF295F
	for <git@vger.kernel.org>; Fri,  8 Aug 2008 13:05:26 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <7v1w0zersg.fsf_-_@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91654>

Junio C Hamano gitster-at-pobox.com |Lists| wrote:
>  --paginate::
> -	Pipe all output into 'less' (or if set, $PAGER).
> +	Pipe all output into 'less' (or if set, $PAGER).  Note that this
> +	implies that the exit code you see from the command will be that
> +	of the pager, not git.

Thank you for the attention, Junio.

I don't want to be a troll... But in my original post, I write that git
log exits with 0 even when there are --check failures *and* --no-pager
is used.

$ PAGER=3Dcat git --no-pager log HEAD~20..HEAD --check --exit-code
$ echo $?
0

Here I don't think the pager is involved, and so perhaps this is an
unrelated issue.

Since the pager/exit code issue is going to be looked at post 1.6.0
herhaps this is low-priority: Nowhere in man git-diff does it mention
the pager or less or that git-diff by default behaves as if
-p/--paginate from "man git" had been given. I personally would not hav=
e
thought to look there or caught the connection. But perhaps I'm
bikeshedding.

If I'm percieved as trolling: Please let me know. This documentation
string took time out of my day. (Less, though than this thread has! :D)

Peter

--=20
Peter Valdemar M=F8rch
http://www.morch.com
