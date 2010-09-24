From: Raja R Harinath <harinath@hurrynot.org>
Subject: Re: [PATCH 03/24] t9300 (fast-import): guard "export large marks" test setup
Date: Fri, 24 Sep 2010 16:31:00 +0530
Message-ID: <8762xve783.fsf@hariville.hurrynot.org>
References: <20100701031819.GA12524@burratino>
	<20100701054849.GA14972@burratino> <20100817170216.GA14491@kytes>
	<20100905031528.GA2344@burratino> <20100905032253.GB2344@burratino>
	<20100924065900.GA4666@burratino> <20100924070950.GD4666@burratino>
	<20100924103452.GI22658@kytes>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 24 13:40:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz6df-0005Km-9i
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 13:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755348Ab0IXLkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 07:40:10 -0400
Received: from lo.gmane.org ([80.91.229.12]:56474 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754085Ab0IXLkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 07:40:09 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Oz6dH-0005AO-L6
	for git@vger.kernel.org; Fri, 24 Sep 2010 13:40:03 +0200
Received: from 117.192.130.161 ([117.192.130.161])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 13:40:03 +0200
Received: from harinath by 117.192.130.161 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 13:40:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 117.192.130.161
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/24.0.50 (gnu/linux)
Cancel-Lock: sha1:qwsGM4aB/B3SFjtuST3SiRz0TRQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156978>

Hi,

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Jonathan Nieder writes:
>>  test_expect_success 'A: export marks with large values' '
>> +	test_tick &&
>> +	mt=$(git hash-object --stdin </dev/null) &&
>> +	>input.blob &&
>> +	>marks.exp &&
>> +	>tree.exp &&
>> +
>> +	cat >input.commit <<-EOF &&
>> +	commit refs/heads/verify--dump-marks
>
> Nit: Maybe change this to verify--export-marks corresponding to the
> `--export-marks` feature of fast-import? The ref for testing the
> `--import-marks` feature is already called `verify--import-marks`.

Fair enough.  I just went with the name of the routine that had the bug:
dump_marks_helper.

- Hari
