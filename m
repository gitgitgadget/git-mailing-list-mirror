From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 01/10] Define a structure for object IDs.
Date: Thu, 12 Mar 2015 11:28:10 +0100
Message-ID: <55016A3A.6010100@alum.mit.edu>
References: <1425770645-628957-1-git-send-email-sandals@crustytoothpaste.net>	<1425770645-628957-2-git-send-email-sandals@crustytoothpaste.net>	<CEA07500-9F47-4B24-AD5D-1423A601A4DD@gmail.com>	<20150311220825.GB46326@vauxhall.crustytoothpaste.net> <xmqqr3sv3vsf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: "Kyle J. McKay" <mackyle@gmail.com>, git@vger.kernel.org,
	Andreas Schwab <schwab@linux-m68k.org>
To: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Thu Mar 12 11:28:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YW0Lv-00004s-Sj
	for gcvg-git-2@plane.gmane.org; Thu, 12 Mar 2015 11:28:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753211AbbCLK21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2015 06:28:27 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:57580 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750973AbbCLK20 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2015 06:28:26 -0400
X-AuditID: 12074414-f797f6d000004084-e7-55016a3d89a5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 7A.84.16516.D3A61055; Thu, 12 Mar 2015 06:28:13 -0400 (EDT)
Received: from [192.168.69.130] (p4FC9671C.dip0.t-ipconnect.de [79.201.103.28])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t2CASBbQ028925
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 12 Mar 2015 06:28:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.5.0
In-Reply-To: <xmqqr3sv3vsf.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsUixO6iqGubxRhqsOiKukXXlW4mi4beK8wW
	l/cuZ7Fom/mDyaJ/aQebA6vH8pt/mTx2zrrL7nHocAejx8VLyh6fN8kFsEZx2yQllpQFZ6bn
	6dslcGccmnyHteCDYMWGtY4NjPN5uxg5OSQETCRmXrjBCGGLSVy4t56ti5GLQ0jgMqPEkx+/
	GSGc80wSd77uYQWp4hXQlpjzfReYzSKgKjHhQQ8biM0moCuxqKeZCcQWFQiSeHnrLyNEvaDE
	yZlPWEBsEYEkiYkrZjKD2MwCuRI3/ywDqxcWcJD4ua6PHcQWEljGJNF+wgXE5hSwltjy8zwT
	RL2exI7rv1ghbHmJ5q2zmScwCsxCsmIWkrJZSMoWMDKvYpRLzCnN1c1NzMwpTk3WLU5OzMtL
	LdK10MvNLNFLTSndxAgJcZEdjEdOyh1iFOBgVOLhfcDKGCrEmlhWXJl7iFGSg0lJlHd/PFCI
	Lyk/pTIjsTgjvqg0J7X4EKMEB7OSCK+EK1CONyWxsiq1KB8mJc3BoiTO+22xup+QQHpiSWp2
	ampBahFMVoaDQ0mC90gGUKNgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KFLji4Gx
	CpLiAdp7DqSdt7ggMRcoCtF6ilFRSpx3H0hCACSRUZoHNxaWuF4xigN9KczLlQlUxQNMenDd
	r4AGMwENZrH+HwI0uCQRISXVwJjFk3H3UebNsqdlcw+vOL5MbML5hBliew/9OXKGfb3rau8T
	Lb3e/WlzdxwS/79XhNcqsHvTqnS7n4YTI+55G9bs+L3Mhu9fj9sz/gJn6dlMz64+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265358>

On 03/12/2015 01:26 AM, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
>> Michael Haggerty recommended that I call the structure element sha1
>> instead of oid in case we want to turn this into a union if we decide to
>> go the additional hash route.
> 
> I'd advise against it.
> 
> As I wrote in $gmane/265337 in response to Michael:
> 
>     > 4. We continue to support working with SHA-1s declared to be (unsigned
>     > char *) in some performance-critical code, even as we migrate most other
>     > code to using SHA-1s embedded within a (struct object_id). This will
>     > cost some duplication of code. To accept this approach, we would need an
>     > idea of *how much* code duplication would be needed. E.g., how many
>     > functions will need both (unsigned char *) versions and (struct
>     > object_id *) versions?
> 
>     ...
> 
>     I do not know what kind of code duplication you are worried about,
>     though.  If a callee needs "unsigned char *", the caller that has a
>     "struct object_id *o" should pass o->hash to the callee.
> 
> And that would break the abstraction effort if you start calling the
> field with a name that is specific to the underlying hash function.
> The caller has to change o->sha1 to o->sha256 instead of keeping
> that as o->oid and letting the callee handle the implementation
> details when calling
> 
>         if (!hashcmp(o1->oid, o2->oid))
>                 ; /* they are the same */
>         else
>                 ; /* they are different */
> [...]

Hmm, I guess you imagine that we might sometimes pack SHA-1s, sometimes
SHA-256s (or whatever) in the "oid" field, which would be dimensioned
large enough for either one (with, say, SHA-1s padded with zeros).

I was imagining that this would evolve into a union (or maybe struct) of
different hash types, like

    struct object_id {
        unsigned char hash_type;
        union {
            unsigned char sha1[GIT_SHA1_RAWSZ];
            unsigned char sha256[GIT_SHA256_RAWSZ];
        } hash;
    };

BTW in either case, any hopes of mapping object_id objects directly on
top of buffer memory would disappear.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
