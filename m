From: Morten Stenshorne <mstensho@opera.com>
Subject: Re: Bug: [hostname:port]:repo.git notation no longer works (for ssh)
Date: Fri, 27 Sep 2013 16:43:04 +0200
Message-ID: <8738oqz5on.fsf@aeneas.oslo.osa>
References: <87vc1mg01t.fsf@aeneas.oslo.osa>
	<CABURp0pNcLEELwg-putH_Wtab-gTrMXTB7uGPMZSLfgXnFttew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 27 16:42:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPZFm-0000Wq-SD
	for gcvg-git-2@plane.gmane.org; Fri, 27 Sep 2013 16:42:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753961Ab3I0Omm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Sep 2013 10:42:42 -0400
Received: from smtp.opera.com ([213.236.208.81]:56086 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753503Ab3I0Omm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Sep 2013 10:42:42 -0400
Received: from aeneas.oslo.osa (gw-idc-bgp-c.opera.com [213.236.208.19])
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id r8REgcAt003824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 27 Sep 2013 14:42:39 GMT
Received: from aeneas.oslo.osa (localhost [127.0.0.1])
	by aeneas.oslo.osa (8.14.4/8.14.4/Debian-4) with ESMTP id r8REh4DX000621
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2013 16:43:04 +0200
Received: (from mstensho@localhost)
	by aeneas.oslo.osa (8.14.4/8.14.4/Submit) id r8REh4FO000620;
	Fri, 27 Sep 2013 16:43:04 +0200
X-Authentication-Warning: aeneas.oslo.osa: mstensho set sender to mstensho@opera.com using -f
X-mstensho: sent-copy
In-Reply-To: <CABURp0pNcLEELwg-putH_Wtab-gTrMXTB7uGPMZSLfgXnFttew@mail.gmail.com>
	(Phil Hord's message of "Fri, 27 Sep 2013 10:31:35 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235466>

Phil Hord <phil.hord@gmail.com> writes:

> On Fri, Sep 27, 2013 at 4:07 AM, Morten Stenshorne <mstensho@opera.com> wrote:
>> If I don't go via the ssh tunnel (I finally have some VPN stuff these
>> days, so I don't really need the tunnel thing anymore, but that's going
>> to be a lot of remotes to update, so I'd prefer it just worked like it
>> used to):
>>
>> -            url = [localhost:2223]:blink.git
>> +            url = git:blink.git
>>
>> ... it works fine.
>
>
> Until you get a proper fix, I wonder if this will help:
>
>   git config --global --add url."git:".insteadOf  "[localhost:2223]:"
>
> See "git help config" for details on the insteadOf config setting.

Yes, that works. Thanks!

-- 
---- Morten Stenshorne, developer, Opera Software ASA ----
------------------ http://www.opera.com/ -----------------
