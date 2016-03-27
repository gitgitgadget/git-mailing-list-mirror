From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH v10 3/3] commit: add a commit.verbose config variable
Date: Sun, 27 Mar 2016 14:07:33 +0200
Message-ID: <20160327140733.Horde.hQiEcpos_hNprvjPS1zIbi2@webmail.informatik.kit.edu>
References: <01020153b478cfab-5309f834-7617-4a7f-a3e9-93f0dcf4a6be-000000@eu-west-1.amazonses.com>
 <1459079497-19121-1-git-send-email-szeder@ira.uka.de>
 <CAFZEwPOhTC_LjUPHMN0PJsc94gvmHgmQL2Xe63oRGOiEMR2jjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 27 14:07:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ak9Tv-0001P2-CU
	for gcvg-git-2@plane.gmane.org; Sun, 27 Mar 2016 14:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbcC0MHj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Mar 2016 08:07:39 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:43866 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751562AbcC0MHj convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Mar 2016 08:07:39 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1ak9Tk-0004PC-5e; Sun, 27 Mar 2016 14:07:36 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1ak9Th-00018N-Mp; Sun, 27 Mar 2016 14:07:33 +0200
Received: from x590d8713.dyn.telefonica.de (x590d8713.dyn.telefonica.de
 [89.13.135.19]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Sun, 27 Mar 2016 14:07:33 +0200
In-Reply-To: <CAFZEwPOhTC_LjUPHMN0PJsc94gvmHgmQL2Xe63oRGOiEMR2jjQ@mail.gmail.com>
User-Agent: Horde Application Framework 5
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1459080456.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290004>


Quoting Pranit Bauva <pranit.bauva@gmail.com>:

> On Sun, Mar 27, 2016 at 5:21 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de=
> wrote:
>>> +test_expect_success 'commit.verbose true and --no-verbose' '
>>> +     git -c commit.verbose=3Dtrue commit --amend --no-verbose &&
>>> +     ! test -s out
>>
>> Please use the test_must_be_empty helper instead, because it has a
>> nice, human-readable name and it complains with a helpful error
>> message if something goes wrong, whereas 'test -s' just fails
>> silently.
>
> Thanks for pointing it out. I was unsure whether 'test -s' is a good
> choice but used it since I did not know any other alternative.

t/test-lib-functions.sh contains all our test helpers functions, that's
where you can look for a suitable helper, should it be necessary.
