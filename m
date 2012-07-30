From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Cannot delete weirdly named branch
Date: Mon, 30 Jul 2012 19:22:17 +0200
Message-ID: <5016C2C9.5050904@alum.mit.edu>
References: <CAGhmpEFg2ZcwqO=wDNPLfPCnrobq4oOcwvFCm27vrEuiES2XbQ@mail.gmail.com> <CAGhmpEGEZchXc4DqZ21BAKxf6_mHRp=TOUH8s=GG0vPscz1kfg@mail.gmail.com> <7vsjcil3o5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "abhisekpan@gmail.com" <abhisekpan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 19:29:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvtmZ-0000Ag-Ub
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 19:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754158Ab2G3R3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 13:29:23 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:43418 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753631Ab2G3R3W (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jul 2012 13:29:22 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Jul 2012 13:29:22 EDT
X-AuditID: 1207440f-b7fde6d00000095c-a8-5016c2cceeae
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id F9.71.02396.CC2C6105; Mon, 30 Jul 2012 13:22:20 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q6UHMIvc018446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 30 Jul 2012 13:22:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
In-Reply-To: <7vsjcil3o5.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsUixO6iqHvmkFiAwfxOdovFXT4WXVe6mSwa
	eq8wOzB77Jx1l93j4iVlj8+b5AKYo7htkhJLyoIz0/P07RK4M7Y8+8RYcImlYuPtVsYGxpvM
	XYycHBICJhITT05nhbDFJC7cW8/WxcjFISRwmVFi8vJHUM5xJommKb0sIFW8AtoSGzv+gNks
	AqoSfXMvgdlsAroSi3qamUBsUYEQiTXfpjBC1AtKnJz5BKxGREBNYmLbITCbWcBNov3LXzYQ
	W1hAX2Ll0aOsEMv2M0rsOfUHbBCngJnE4YPvgBIcQA3WEt92F0H0yktsfzuHeQKjwCwkK2Yh
	VM1CUrWAkXkVo1xiTmmubm5iZk5xarJucXJiXl5qka6JXm5miV5qSukmRkjg8u9g7Fovc4hR
	gINRiYfX8LJogBBrYllxZe4hRkkOJiVRXqMtYgFCfEn5KZUZicUZ8UWlOanFhxglOJiVRHgn
	iQDleFMSK6tSi/JhUtIcLErivOpL1P2EBNITS1KzU1MLUotgsjIcHEoSvIsPAjUKFqWmp1ak
	ZeaUIKSZODhBhnNJiRSn5qWkFiWWlmTEgyI1vhgYqyApHqC900HaeYsLEnOBohCtpxh1OVb9
	fnKbUYglLz8vVUqcdydIkQBIUUZpHtwKWJp6xSgO9LEwbyxIFQ8wxcFNegW0hAloSYgD2JKS
	RISUVAOj5GSJFg+TQylFIbuj41kneXz1/fg38+5ldaetJvcdqxY+5fvN5PTe6ELn2ymOd/bv
	2Pye82p62sGqY2kG5U3XO20P7tn1cLfFA4c7LDNdX6zyW2Xffq/l/51+qXc+W21f 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202588>

On 07/23/2012 08:42 PM, Junio C Hamano wrote:
> "abhisekpan@gmail.com" <abhisekpan@gmail.com> writes:
>
>> Now I cannot delete this branch. Running:
>> git branch -d --tracking
>> gives an error: unknown option `tracking'
>
> I do not think this is supposed to work, but it does by accident.
>
>      $ git branch -d -- --tracking
>      Deleted branch --tracking (was 8670e20).

The plumbing command "git update-ref -d refs/heads/--tracking" can also 
be used to delete such a branch.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
