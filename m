From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: State of CVS-to-git conversion tools (Was: Re: cvsps: bad usage:
 invalid argument --norc)
Date: Mon, 15 Apr 2013 07:00:07 +0200
Message-ID: <516B8957.5010508@alum.mit.edu>
References: <323381594.20130414121834@gmail.com> <673219382.20130414124800@gmail.com> <20130414113351.GA1299@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ilya Basin <basinilya@gmail.com>, git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Mon Apr 15 07:07:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URbdQ-0005sS-UO
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 07:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932984Ab3DOFHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 01:07:14 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:43739 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932513Ab3DOFHM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Apr 2013 01:07:12 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Apr 2013 01:07:12 EDT
X-AuditID: 12074412-b7f216d0000008d4-62-516b895aaf26
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id CD.0F.02260.A598B615; Mon, 15 Apr 2013 01:00:10 -0400 (EDT)
Received: from [192.168.69.140] (p57A2542B.dip.t-dialin.net [87.162.84.43])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3F5078W013178
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 15 Apr 2013 01:00:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <20130414113351.GA1299@thyrsus.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsUixO6iqBvVmR1o8GgOm8XRv6YWV7f4WHRd
	6WZyYPbYOesuu8eyr50sHp83yQUwR3HbJCWWlAVnpufp2yVwZyxpvMpcsIqj4ubHDrYGxlNs
	XYwcHBICJhLtu0S7GDmBTDGJC/fWA4W5OIQELjNK3P3VzQSSEBI4zSRxv9kaxOYV0Ja4+aWX
	BcRmEVCVOLn1OlgNm4CuxKKeZjBbVCBMYtX6ZcwQ9YISJ2c+YQHZJSIgLHGsTw0kzCxgKXHs
	yzewEmGBDIl1qzsYIVZVSlzcN4ENxOYUMJBY0vCTHaJeR+Jd3wNmCFteYvvbOcwTGAVmIdkw
	C0nZLCRlCxiZVzHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmunlZpbopaaUbmKEBK3QDsb1J+UO
	MQpwMCrx8E7Qzg4UYk0sK67MPcQoycGkJMo7rRUoxJeUn1KZkVicEV9UmpNafIhRgoNZSYT3
	fwRQjjclsbIqtSgfJiXNwaIkzvtzsbqfkEB6YklqdmpqQWoRTFaGg0NJgpelA6hRsCg1PbUi
	LTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhSl8cXAOAVJ8QDtzQJp5y0uSMwFikK0nmI05pi1
	9clrRo6VV4CkEEtefl6qlDhvGUipAEhpRmke3CJYunrFKA70tzDvt3agKh5gqoOb9wpoFRPQ
	Kp+96SCrShIRUlINjLXrb335uV+aUSZ1knl3t5aJ9pu+n085wurdWJdL5/ZUfPl9x3aCbO+x
	zducJI6+sRBN8/pveelg6b2vPiYHpLbdYk0unLAlYb9S0uSeZadeOs1RqZtoMde9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221192>

On 04/14/2013 01:33 PM, Eric S. Raymond wrote:
> [...]
> I wish I could point you at a convertor I really trust.  I can't.
> There is a third tool, cvs2git (based on the analyzer from cvs2svn)
> that I don't maintain, which has problems of its own.
                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Again I request that instead of spreading non-specific FUD about
cvs2git, you describe concrete problems so that I can improve the tool.
 So far about the only problems that you have mentioned that have not
been addressed have been stylistic trivia like that you object that
cvs2git writes its outputs by pass, to two separate files, rather than
writing all of its output to stdout, and that you are bothered that it
names its temporary directory "cvs2svn-tmp" rather than "cvs2git-tmp".

I would like to fix any conversion deficiencies you can find.  I stand
behind this tool and think it is the best one out there for extracting
history from CVS.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
