From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: Re: [PATCH] Add an optional <mode> argument to commit/status -u|--untracked-files option
Date: Wed, 04 Jun 2008 07:26:48 +0900
Message-ID: <200806032227.m53MRLeC005668@mi0.bluebottle.com>
References: <4845B4E8.1040402@trolltech.com>
    <7viqwvk04y.fsf@gitster.siamese.dyndns.org>
    <c9062d05cabcbd45657e89b03eac9715a46f8b79.1212498900.git.marius@trolltech.com>
    <20080603201421.GB17260@sigill.intra.peff.net>
    <4845B4E8.1040402@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 00:29:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3f01-0000NQ-Jq
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 00:29:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758814AbYFCW11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 18:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756543AbYFCW1Z
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 18:27:25 -0400
Received: from mi0.bluebottle.com ([206.188.25.15]:53998 "EHLO
	mi0.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755984AbYFCW1W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 18:27:22 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi0.bluebottle.com (8.13.1/8.13.1) with ESMTP id m53MRLeC005668
	for <git@vger.kernel.org>; Tue, 3 Jun 2008 15:27:21 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:subject:date:in-reply-to:references:
	mime-version:content-type:content-transfer-encoding:x-trusted-delivery;
	b=iK+btnkl+9YlAp5bc5qiCLcg62oexT113tG3X8yPXsNkuPD8CDl7fhZooP5hwEvqr
	Sx3opQFQVoTOopqZCsFlr85E2wsYmd7tAkbz0WHwPG8RP5vNDF4vjjsMKXD8Q/F
Received: from nanako3.mail.bluebottle.com ([212.62.97.21])
	(authenticated bits=0)
	by fe1.bluebottle.com (8.13.1/8.13.1) with ESMTP id m53MRACa029962
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 3 Jun 2008 15:27:17 -0700
In-Reply-To: <4845B4E8.1040402@trolltech.com>
X-Trusted-Delivery: <832e55728113fa47b1dbd33b28c024dd>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83720>

Quoting Marius Storm-Olsen <marius@trolltech.com> writes:

> Jeff King said the following on 03.06.2008 22:14:
>> On Tue, Jun 03, 2008 at 03:09:10PM +0200, Marius Storm-Olsen wrote:
>>
>>> +-u[<mode>]|--untracked-files[=<mode>]::
>>> +	Show all untracked files.
>>> +	The mode parameter is optional, and is used to specify
>>> +	the handling of untracked files. The possible options are:
>>> +		none   - Show no untracked files
>>> +		normal - Shows untracked files and directories
>>> +		all    - Also shows individual files in untracked directories.
>>> +	If the mode parameter is not specified, the defaults is
>>> +	'all'.
>>
>> Hmm. Doesn't this change bundling semantics of "git commit -us"? Do we
>> care?
>
> You are right. This is the joy of the parse-options() handling of
> short-options with optional arguments.
>
> -us before meant:
>     1) commit
>     2) show all untracked files
>     3) sign-of the commit
>
> I guess it would be possible to reparse the options without the -u, if
> the argument is not one of the three (none,normal,all), but I'm not
> sure it's _that_ critical. Opinions?

Isn't the second bullet point in the description in:

    http://www.kernel.org/pub/software/scm/git/docs/gitcli.html

good enough?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Find out how you can get spam free email.
http://www.bluebottle.com/tag/3
