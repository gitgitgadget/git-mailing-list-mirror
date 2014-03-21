From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: File extension conflict when working with git and latex
Date: Fri, 21 Mar 2014 22:31:00 +0100
Message-ID: <532CAF94.8040108@alum.mit.edu>
References: <20140321161324.GC2965@fu.192.168.200.1> <xmqqr45vtnay.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthias Beyer <mail@beyermatthias.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 22:31:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR720-0000OI-7B
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 22:31:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbaCUVbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 17:31:08 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:51474 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751289AbaCUVbF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Mar 2014 17:31:05 -0400
X-AuditID: 12074411-f79ab6d000002f0e-44-532caf97a343
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id D3.49.12046.79FAC235; Fri, 21 Mar 2014 17:31:04 -0400 (EDT)
Received: from [192.168.69.148] (p57A25836.dip0.t-ipconnect.de [87.162.88.54])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2LLV1Nl004671
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 21 Mar 2014 17:31:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <xmqqr45vtnay.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsUixO6iqDtjvU6wwYpnTBZdV7qZLBp6rzBb
	7N24j9WB2WPh59VMHhcvKXt83iQXwBzFbZOUWFIWnJmep2+XwJ3RsH4uS8ED3oqJ366zNzC+
	5upi5OSQEDCRuHDxLROELSZx4d56ti5GLg4hgcuMEkePv4VyzjFJbJy3D6yKV0BbouHeSRYQ
	m0VAVeJU/2WwOJuArsSinmYwW1QgWGL15QcsEPWCEidnPgGzRQTUJCa2HQKzmQXsJX6vecAI
	YgsLuEic/LKaGcQWEkiWWD/tJjuIzSlgLfH15gugOAfQdeISPY1BEK06Eu/6HjBD2PIS29/O
	YZ7AKDgLybZZSMpmISlbwMi8ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXVC83s0QvNaV0EyMk
	pAV3MM44KXeIUYCDUYmH9yK3drAQa2JZcWXuIUZJDiYlUd7QZTrBQnxJ+SmVGYnFGfFFpTmp
	xYcYJTiYlUR4A0FyvCmJlVWpRfkwKWkOFiVxXr4l6n5CAumJJanZqakFqUUwWRkODiUJ3n1r
	gRoFi1LTUyvSMnNKENJMHJwgw7mkRIpT81JSixJLSzLiQREcXwyMYZAUD9BewXUge4sLEnOB
	ohCtpxiNOTZsW9PIxHFr+cZGJiGWvPy8VClxXnuQTQIgpRmleXCLYMnsFaM40N/CvMogA3mA
	iRBu3iugVUxAq/inaoGsKklESEk1MO6wl0hvu75Ap/Led8/729scYhq/qp0TFbieM8nyT42Z
	FFvmvd1WV0/q8Ppdt+4pm2alnff3QceEyk88W3MSgis9awu/er5sb74UIrj8CY9y 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244752>

On 03/21/2014 07:32 PM, Junio C Hamano wrote:
> Matthias Beyer <mail@beyermatthias.de> writes:
> 
>> I know, I can fix this by fixing the clean task in my Makefile. But
>> maybe someone somewhere on this world doesn't know the git internals
>> as good as me (and, of course, my coworker). Is there _any chance
>> at all_ that this gets mentioned somewhere, so others don't fall into
>> this pit?
> 
> Surely, we are here to please ;-)  All of us want to make sure
> newbies do not shoot themselves in the foot.
> 
> But the problem is what exactly should be mentioned.  With a fresh
> wound with your LaTeX project still in your mind, you may be tempted
> to special case ".idx", but other newbies may inflict the same kind
> of hurt on themselves with different "find" patterns, e.g.
> 
>     $ find . -name '[0-9a-f]*[0-9a-f]' -type f -print | xargs rm -f
> 
> when they know their project creates hexadecimal-numbered temoprary
> files, or whatever other pattern that match the files they do not
> care about, that also happens to match whatever is in $GIT_DIR.  The
> only common caution that helps us to make sure "others do not fall
> into this pit" is "Files and directories in $GIT_DIR are used to
> record your work; do not muck with them unless you know what you are
> doing e.g. manually repairing a corrupt repository", but that is a
> bit lame, isn't it?

It might help some people to show the "find" incantation for skipping
files under .git, which I think would be something like

    find . -name .git -prune -o \( [...] \) -print0 | xargs -0 rm -f

where "[...]" is whatever condition the user would otherwise use.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
