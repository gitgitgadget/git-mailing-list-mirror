From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 4/4] fast-import: only store commit objects
Date: Tue, 07 May 2013 09:34:07 +0200
Message-ID: <5188AE6F.3030701@alum.mit.edu>
References: <1367555502-4706-1-git-send-email-felipe.contreras@gmail.com> <1367555502-4706-5-git-send-email-felipe.contreras@gmail.com> <87y5bw3q1s.fsf@hexa.v.cablecom.net> <CAMP44s1R9hAMZ=DQoPiTVi3+40NpADjVFU7tYovZA8W-PWEhhg@mail.gmail.com> <518785B3.3050606@alum.mit.edu> <87ip2wflg0.fsf@linux-k42r.v.cablecom.net> <518789D1.4010905@alum.mit.edu> <CAMP44s1Nk7YAjNkTq=ShQbzkMasw6bpcEPTXLb8x+2q-vXLRGg@mail.gmail.com> <518874A5.5050002@alum.mit.edu> <7vehdjmffp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 07 09:34:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZcPm-0007aP-6B
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 09:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757383Ab3EGHeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 03:34:13 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:60355 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753633Ab3EGHeL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 May 2013 03:34:11 -0400
X-AuditID: 12074413-b7f226d000000902-8f-5188ae72cb28
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 64.E4.02306.27EA8815; Tue,  7 May 2013 03:34:10 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r477Y8aw024933
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 7 May 2013 03:34:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7vehdjmffp.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsUixO6iqFu0riPQ4MF5K4tfZ3exWBx8nGfR
	daWbyaKh9wqzRf/yLjaLu5dXsTuweeycdZfd48PHOI/br+cze1y8pOzxeZNcAGsUt01SYklZ
	cGZ6nr5dAndG54M97AWz+CqedbxkbGDcwt3FyMEhIWAicXlrchcjJ5ApJnHh3nq2LkYuDiGB
	y4wSa19fhHKOMUlsWbCQEaSKV0Bb4tPes2wgzSwCqhLdCyNAwmwCuhKLepqZQGxRgTCJVeuX
	MUOUC0qcnPmEBcQWEVCTmNh2CMxmFrjFKPGqKQ/EFhawl9j1ZTorxK7XzBK3nj0Ha+YUMJN4
	tG0BVIOOxLu+B8wQtrzE9rdzmCcwCsxCsmMWkrJZSMoWMDKvYpRLzCnN1c1NzMwpTk3WLU5O
	zMtLLdI118vNLNFLTSndxAgJdOEdjLtOyh1iFOBgVOLhVTjVHijEmlhWXJl7iFGSg0lJlFdz
	bUegEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRFeaW2gHG9KYmVValE+TEqag0VJnFdtibqfkEB6
	YklqdmpqQWoRTFaGg0NJgvcryFDBotT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4UKTG
	FwNjFSTFA7T3Dkg7b3FBYi5QFKL1FKMux8orT14zCrHk5eelSonzrgYpEgApyijNg1sBS2uv
	GMWBPhbm/QZSxQNMiXCTXgEtYQJaksDXDrKkJBEhJdXAuHbphc4PdYzvPyyyndbB92ozX93N
	vS3y3MlVHMaffNOZsoy5b0iaZ9vunHlP00263618+7yd13dtLPp161KUcOHlpHUT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223563>

On 05/07/2013 09:12 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>>>>>> CVS stores all of the revisions of a single file in a single filename,v
>>>>>> file in rcsfile(5) format.  The revisions are stored as deltas ordered
>>>>>> so that a single revision can be reconstructed from a single serial read
>>>>>> of the file.
>>>>>>
>>>>>> cvs2git reads each of these files once, reconstructing *all* of the
>>>>>> revisions for a file in a single go.  It then pours them into a
>>>>>> git-fast-import stream as blobs and sets a mark on each blob.
> 
> This is more or less off-topic but in the bigger picture it is more
> interesting and important X-<.
> 
> The way you describe how cvs2git handles the blobs is the more
> efficient way, given that fast-import does not even attempt to
> bother to create good deltas. The only thing it does is to see if
> the current data deltifies against the last object.
> 
> IIRC, CVS's backend storage is mostly recorded in backward delta, so
> if you are feeding the blob data from new to old, then the resulting
> pack would follow Linus's law (the file generally grows over time)
> and would generally give you a good deltified chain of objects.

Yes, you are correct about how CVS orders commits on the mainline.
Branches are stored in the opposite order--oldest to newest--but CVS
users don't tend to get carried away with branches anyway, and if the
changes are small deltafication should help a lot anyway.

Cool.  I knew that fast-import didn't do much in the way of compression,
but I didn't realize that it can compute deltas only between adjacent
blobs.  So cvs2git happily hits the sweet-spot of fast-import.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
