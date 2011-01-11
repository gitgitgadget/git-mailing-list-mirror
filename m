From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: git-repack & big files
Date: Tue, 11 Jan 2011 10:43:37 -0500
Message-ID: <4D2C7AA9.1020506@cfl.rr.com>
References: <1294731438.3300.973.camel@voubian.casa>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pietro Battiston <me@pietrobattiston.it>
X-From: git-owner@vger.kernel.org Tue Jan 11 16:43:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcgO2-0003Ct-Ke
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 16:43:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756185Ab1AKPn3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Jan 2011 10:43:29 -0500
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.121]:36262 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755858Ab1AKPn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 10:43:26 -0500
Authentication-Results: cdptpa-omtalb.mail.rr.com smtp.user=psusi@cfl.rr.com; auth=pass (PLAIN)
X-Authority-Analysis: v=1.1 cv=pepdxKapwHuwCZNFD5uob2wvham6E+RljB0uXw08FdQ= c=1 sm=0 a=IkcTkHD0fZMA:10 a=pg4Dpxby4z7sZisWVyJ9NA==:17 a=Yjvz0eVlVKuMVB3A7kEA:9 a=f2ILoUvFBYVfB4UrHukA:7 a=4ixluXTHsc6vGfQhp8nWBL60YUoA:4 a=QEXdDO2ut3YA:10 a=pg4Dpxby4z7sZisWVyJ9NA==:117
X-Cloudmark-Score: 0
X-Originating-IP: 72.242.190.170
Received: from [72.242.190.170] ([72.242.190.170:1551] helo=[10.1.1.235])
	by cdptpa-oedge03.mail.rr.com (envelope-from <psusi@cfl.rr.com>)
	(ecelerity 2.2.3.46 r()) with ESMTPA
	id 75/15-19545-D9A7C2D4; Tue, 11 Jan 2011 15:43:26 +0000
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <1294731438.3300.973.camel@voubian.casa>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164955>

On 1/11/2011 2:37 AM, Pietro Battiston wrote:
> Since it perfectly does what it is not optimized to do... I then wond=
er
> when it does not do what it declares: if I run git-repack=C2=B2 with =
the
> parameter --window-memory set to, for instance, "100m", it takes
> hundreds and hundreds of MB of memory until it runs out of memory, fa=
ils
> a malloc and aborts.
> So, two questions:

--window-memory reduces the window size to try and stay under the limit=
,
 but the window size can not be reduced below 1.

> 2) do I have any hope that in one way or another my 500+ MB mailboxes
> with relatively small changes over time are archived smartly (=3Ddiff=
s) by
> git at the current state of development? If I understand correctly, t=
he
> project git-bigfiles=C2=B3 would just "solve" my problems by not maki=
ng
> differences of big files.

Git is not a backup tool.  You should use rsync rdiff-backup instead.
