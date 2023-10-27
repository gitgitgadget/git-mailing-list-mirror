Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07BA1EB33
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 13:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280AD1B9
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 06:26:16 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 110A023F67;
	Fri, 27 Oct 2023 09:26:10 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1qwMqo-eX4-00; Fri, 27 Oct 2023 15:26:10 +0200
Date: Fri, 27 Oct 2023 15:26:10 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Marc Branchaud <marcnarc@xiplink.com>
Cc: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	phillip.wood@dunelm.org.uk, git@vger.kernel.org
Subject: Re: using oldest date when squashing commits
Message-ID: <ZTu6cqUec3L2PpUC@ugly>
References: <YjXRM5HiRizZ035p@ugly>
 <9fae5292-d58f-95da-245b-6e205383cb50@kdbg.org>
 <a99b16a8-a06c-4d38-bb78-46ce17411597@gmail.com>
 <ZTeZ3KEQLIVU/sq2@ugly>
 <138631cd-ead3-4f22-95ce-61afccfa409f@gmail.com>
 <xmqqpm143p46.fsf@gitster.g>
 <59731c05-c3f6-4815-8411-783bb1c2aac4@kdbg.org>
 <70b8d4d8-f4b5-4cd7-b73a-1d7393d84266@xiplink.com>
 <ZTuw7ziOnTunMmML@ugly>
 <6d100655-ffd4-4282-87b5-cfdd101dba63@xiplink.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d100655-ffd4-4282-87b5-cfdd101dba63@xiplink.com>

On Fri, Oct 27, 2023 at 09:20:04AM -0400, Marc Branchaud wrote:
>
>On 2023-10-27 08:45, Oswald Buddenhagen wrote:
>> On Fri, Oct 27, 2023 at 08:34:40AM -0400, Marc Branchaud wrote:
>>> I never use "fixup -C" (or -c), but I do use squash/fixup a lot.  I 
>>> find that I would prefer it if Git used the most recent Author date 
>>> from the set of commits being combined, rather than preserving the 
>>> picked commit's Author date.
>>>
>> that would be unreliable, as plain amends wouldn't be reflected. that 
>> may be rare in your workflow, but still.
>
>I'm not talking about amends, plain or otherwise.
>
but why wouldn't you? your use case of marking the date of completion 
naturally covers all ways of amending commits, whether directly or via 
squashing.

regards
