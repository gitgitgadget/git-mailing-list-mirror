From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH v3 17/20] refs: allow ref backend to be set for clone
Date: Thu, 21 Jan 2016 10:08:20 +0100
Message-ID: <20160121100820.Horde.5-2HMBAP-1P3hWXbxgxeBsX@webmail.informatik.kit.edu>
References: <1452857550-25887-1-git-send-email-szeder@ira.uka.de>
 <1453223161.16226.24.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 10:08:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMBER-00034Y-2O
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 10:08:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758546AbcAUJIj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Jan 2016 04:08:39 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:40325 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751224AbcAUJIc convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2016 04:08:32 -0500
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1aMBED-00065a-Tx; Thu, 21 Jan 2016 10:08:29 +0100
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1aMBE4-0005Ix-1H; Thu, 21 Jan 2016 10:08:20 +0100
Received: from x4db25724.dyn.telefonica.de (x4db25724.dyn.telefonica.de
 [77.178.87.36]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Thu, 21 Jan 2016 10:08:20 +0100
In-Reply-To: <1453223161.16226.24.camel@twopensource.com>
User-Agent: Horde Application Framework 5
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1453367309.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284507>


Quoting David Turner <dturner@twopensource.com>:

> Thanks for the suggestions.
>
> With your permission, I will add:
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
>
> to all three of these patches post-squash.  Is that OK?

Sure...

(But does such a trivial one-liner need a sign-off at all, when it's =20
not a standalone patch?)


> On Fri, 2016-01-15 at 12:32 +0100, SZEDER G=C3=A1bor wrote:
>> Hi,
>>
>> This change is more about 'git clone' than about refs, therefore
>> I think the subject line would be better as:
>>
>>   clone: allow setting alternate ref backend
>>
>> Could you please squash this in to keep the completion script up to
>> date?
>> Is there or will there be a way to list available ref backends, so w=
e
>> could complete possible options for --ref-storage=3D<TAB>, too?
>>
>> ------ >8 ------
>>
>> Subject: completion: git clone --ref-storage=3D
>> ---
>> diff --git a/contrib/completion/git-completion.bash
>> b/contrib/completion/git-completion.bash
>> index ab4da7f97917..c970d3c0d0a3 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -1092,6 +1092,7 @@ _git_clone ()
>>  			--depth
>>  			--single-branch
>>  			--branch
>> +			--ref-storage=3D
>>  			"
>>  		return
>>  		;;
>>
