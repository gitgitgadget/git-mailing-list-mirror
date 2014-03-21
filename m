From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v5] commit.c: use skip_prefix() instead of starts_with()
Date: Fri, 21 Mar 2014 16:53:36 +0100
Message-ID: <532C6080.9010503@alum.mit.edu>
References: <1393970831-3558-1-git-send-email-tanayabh@gmail.com> <532C5F47.3020801@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, max@quendi.de
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 16:53:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR1lR-00063N-Bt
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 16:53:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbaCUPxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 11:53:41 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:45125 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750708AbaCUPxk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Mar 2014 11:53:40 -0400
X-AuditID: 1207440c-f79656d000003eba-f4-532c6083bb30
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 76.88.16058.3806C235; Fri, 21 Mar 2014 11:53:39 -0400 (EDT)
Received: from [192.168.69.148] (p57A25836.dip0.t-ipconnect.de [87.162.88.54])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2LFraxQ020486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 21 Mar 2014 11:53:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <532C5F47.3020801@alum.mit.edu>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsUixO6iqNucoBNssPKBjkXXlW4mi4beK8wW
	n/9dZ7P4deE9swOLx85Zd9k9Ll5S9piwfS+zx+dNcgEsUdw2SYklZcGZ6Xn6dgncGV9O7WQv
	2M9cMWn9HfYGxqdMXYycHBICJhJbt69khrDFJC7cW8/WxcjFISRwmVHi8ZOXTBDOOSaJ9nOf
	wap4BbQl1p1fwgJiswioStz5/hEsziagK7GopxlsqqhAsMTqyw9YIOoFJU7OfAJmiwioSPzc
	dRusnlnAUqLl5TewuLCAj8TbCVvYQWwhgUSJR7N+sYHYnAI6ErsvHwWq4QC6TlyipzEIolVH
	4l3fA6gx8hLb385hnsAoOAvJtllIymYhKVvAyLyKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdQ
	LzezRC81pXQTIyTMeXYwflsnc4hRgINRiYe3glM7WIg1say4MvcQoyQHk5Iob0K8TrAQX1J+
	SmVGYnFGfFFpTmrxIUYJDmYlEd7mWKAcb0piZVVqUT5MSpqDRUmcV3WJup+QQHpiSWp2ampB
	ahFMVoaDQ0mC90gcUKNgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KILji4ExDJLi
	Adq7AuQm3uKCxFygKETrKUZdjg3b1jQyCbHk5eelSonzHgIpEgApyijNg1sBS2qvGMWBPhbm
	rQKp4gEmRLhJr4CWMAEt4Z+qBbKkJBEhJdXAWJD+ePtcT18hSWe/ng/HNiZsmNZnd3PSTUVf
	BzH1/IxItQcJm4XbVjZ96fK75s0mkf9VKeuby3T9Yg/Hh/qWExf8fbQu8KL/feb8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244693>

On 03/21/2014 04:48 PM, Michael Haggerty wrote:
> On 03/04/2014 11:07 PM, Tanay Abhra wrote:
>> [...]
>> +		found = skip_prefix(buf, sigcheck_gpg_status[i].check + 1);
>> +		if(!found) {
> 
> Nit: There should be a space between "if" and the opening parenthesis.

Oops, I see I am too late.  Junio must have fixed this when queuing the
patch.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
