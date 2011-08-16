From: Eric Blake <eblake@redhat.com>
Subject: Re: [bug-patch] rejecting patches that have an offset
Date: Tue, 16 Aug 2011 17:10:44 -0600
Organization: Red Hat
Message-ID: <4E4AF8F4.60709@redhat.com>
References: <4E49A8EA.5020507@redhat.com> <1313534889.5598.21.camel@schurl.linbit>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: bug-patch@gnu.org, Git Mailing List <git@vger.kernel.org>
To: Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 17 01:10:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtSmb-00017M-Lk
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 01:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803Ab1HPXKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 19:10:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57420 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751554Ab1HPXKs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 19:10:48 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p7GNAjl0015036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 16 Aug 2011 19:10:45 -0400
Received: from [10.3.113.118] (ovpn-113-118.phx2.redhat.com [10.3.113.118])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p7GNAimS030880;
	Tue, 16 Aug 2011 19:10:45 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.18) Gecko/20110621 Fedora/3.1.11-1.fc14 Lightning/1.0b3pre Mnenhy/0.8.3 Thunderbird/3.1.11
In-Reply-To: <1313534889.5598.21.camel@schurl.linbit>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179486>

On 08/16/2011 04:48 PM, Andreas Gruenbacher wrote:
> Eric,
>
> On Mon, 2011-08-15 at 17:16 -0600, Eric Blake wrote:
>> It would have saved me a lot of time if both 'patch' and 'git apply'
>> could be taught a mode of operation where they explicitly reject a patch
>> that cannot be applied without relying on an offset.
>
> that sounds reasonable.  Can you send a patch or at least add a bug on
> Savannah?

Bug opened: https://savannah.gnu.org/bugs/index.php?34031

>
>> It might also be nice if patch could learn the algorithm that appears to
>> match the git behavior, where when there are multiple points with
>> identical context (viewing just the context in isolation), but where
>> those locations differ in function location (as learned by the @@ header
>> line in the patch file), then the preferred offset is the one in the
>> named function, even if that is not the closes context match to the line
>> number given in the patch file.
>
> Sounds interesting; a patch for that would be great as well.

Bug opened: https://savannah.gnu.org/bugs/index.php?34032

-- 
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org
