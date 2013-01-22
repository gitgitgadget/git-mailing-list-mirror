From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug in latest gitk - can't click lines connecting commits
Date: Tue, 22 Jan 2013 09:28:23 -0800
Message-ID: <7v622p9lfs.fsf@alter.siamese.dyndns.org>
References: <20130101172156.GA22450@gmail.com>
 <1kw18d3.5sftkl125qdz4M%stefan@haller-berlin.de>
 <20130101232220.GD20724@iris.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Haller <stefan@haller-berlin.de>,
	Jason Holden <jason.k.holden.swdev@gmail.com>,
	git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Jan 22 18:28:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxheR-0000A5-Sw
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 18:28:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754388Ab3AVR21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 12:28:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51374 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752750Ab3AVR20 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 12:28:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2433B627;
	Tue, 22 Jan 2013 12:28:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=enrga0GR2RsCeyDaqtad+cFbTSQ=; b=IE3YXA
	4BrA2beoIDD/qiAM5JirZkhYvmfEdJE1/GvVM+CX0aOxM+vbOgOfT/5eXiSunYK4
	9h+pesiKlkGAaSQfvvhVPUYHN0xTX73CbSdGHohZdM7ar9bvu1yLkamIgb/BQAmZ
	0DHLKkU7+vCpOUfv53j9tEacuIW/Uvzt56wbk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qgwBnDFJabhKE7tc2lbR8EiyGV+UAEh5
	uJbxho6IaL0cbU6NQQviFPRy3Vs6JPODa8RPXBEk+hDiBYsS98eQxRx5ie+41cSx
	/nmux5kx/9n8tA1hnhS15zKrQosDJnBvRwphtsbqjOEQIqzxsswTHnzT1s//I4gl
	QRS5rBymEdk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6A2BB626;
	Tue, 22 Jan 2013 12:28:25 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2FD95B622; Tue, 22 Jan 2013
 12:28:25 -0500 (EST)
In-Reply-To: <20130101232220.GD20724@iris.ozlabs.ibm.com> (Paul Mackerras's
 message of "Wed, 2 Jan 2013 10:22:20 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 20881BF8-64B9-11E2-B49E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214241>

Paul Mackerras <paulus@samba.org> writes:

> On Tue, Jan 01, 2013 at 06:54:23PM +0100, Stefan Haller wrote:
>> Jason Holden <jason.k.holden.swdev@gmail.com> wrote:
>> 
>> > I was testing some patches against the latest gitk, and noticed that when I
>> > click the mouse on the lines that connect the commits in the history graph,
>> > I get an error popup with:
>> >  Error: can't read "cflist_top": no such variable
>> > 
>> > Looks like this was introduced in gitk commit b967135d89e8d8461d059
>> >  gitk: Synchronize highlighting in file view when scrolling diff
>> 
>> A patch that fixes this was proposed over two months ago, and Paul said
>> he had applied it:
>> 
>>   <http://permalink.gmane.org/gmane.comp.version-control.git/208162>
>> 
>> However, looking at git://ozlabs.org/~paulus/gitk.git it's not there.
>> Paul?
>
> I just forgot to push it out.  It's there now.

I notice that I have a handful of commits that I haven't pulled from
your repository, and the last commit on your 'master' is about 20
days old.  Is it safe for me to pull these now?

I can teach myself that your push is your pull-request, but I do not
think we agreed to arrange it that way yet, so...
