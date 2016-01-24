From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2 1/1] merge-file: let conflict markers match end-of-line
 style of the context
Date: Sun, 24 Jan 2016 17:36:48 +0100
Message-ID: <56A4FDA0.50906@web.de>
References: <cover.1453482052.git.johannes.schindelin@gmx.de>
 <cover.1453632296.git.johannes.schindelin@gmx.de>
 <d71c7abddd4cba85b967f9fe1d33c7c843176ca2.1453632296.git.johannes.schindelin@gmx.de>
 <56A4FB64.4010609@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>,
	Jeff King <peff@peff.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 17:37:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNNew-0004PD-1p
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 17:37:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753783AbcAXQg7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Jan 2016 11:36:59 -0500
Received: from mout.web.de ([212.227.15.3]:64441 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752595AbcAXQg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 11:36:57 -0500
Received: from birne9.local ([213.66.56.100]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0LrHMi-1ZxpPz0aQG-0133Pt; Sun, 24 Jan 2016 17:36:51
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.5.1
In-Reply-To: <56A4FB64.4010609@web.de>
X-Provags-ID: V03:K0:2/ycC8jV2Uc5syh7W90z/MqGCAzNLBso/DSQH0EHvRhCtxSBBrm
 RvpVubuN7guUUQ9Ud1KLtnp784KMVjMj9vx/o8PEsiCm+c+sAJFevTxaduDi+oJKtt0ay8g
 8Q8brLU9FuXI4/OYWIJPlPj+rP1UqF0sjrthKDh2SLNN9FlJuIIZDnrMdJZt9fWzSpZOC/d
 dcqTjc7kVy6dl7vnMjqTQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sxqAFXkUNRA=:vIkV4S5ipG6BqEKOFpFbbl
 kzfBKj/PWMFn4+nBW0eZVctiXTKuBn09zRbVU0U+ANY9WuE+egdH31/8rIS7OPLO2t4UMwW8u
 zr+LwTZC33nCzbFAwC3UOUQpe20lY+FWl6wf3ziFDBXiomwRS/aXm5ge6E4AcJ8qT/LqmTpmy
 q5kd0uulzzpNG3R8bptgUSy3pAsvuIvGHtU/z44Evnmw/o3p9wthyhBxURTrQpG4vVVH9kz4W
 aXAlG2zJ0K3rkhvPFBmu9/r5us7O6z1iVpb6fs5CMU9WyxZBQFo4Y1gX0zK/c4WZ34tQNF82Y
 lBqYydUOpgTJ1NqpmlG6BpnMvpu4MmRGptLGZBZ1Jofx0IUnJcwbLWZIye5uln3Ni6BeaZlvu
 aOXXlwPWMzTclJM+j2RorSsVK8e3VRNbqYlU05/gXhBDVRje5zAmKyRVGvYZUyeIkqUFG/WfS
 kpbN0pAbTc9+HzgDWKecVOrrOAFpp8ZaAlbbHq8KV31joBf1eU+p7AfnREjK7rOtjU6yQVdiC
 u2Shwzhyv7v1Gbe9Uf/das7nl8GuHGdsoxoUAn5oBcsckygJXMeVjp92Cech0FpXqdAiyORzE
 lZyFd/sw8ub/Y8U1J2f+/pGlaseOQHL4GDLxdYBsqTaQK1v1shTIAO5iDJ+j/6IWr5156QlAm
 sqhEqJoy/2bJNGFnChVr49bctRUXtCyXfCoABz9cA151T56eBSXIWAjSoTWbnouy4W1pF8gP9
 3796EDoqlR+4wxzE2DFHcZvWFMI+v/Kb7SmXI2yA2u1rQd5Wyii5Epg/hgFSECGrWptX6XpL 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284686>

On 24.01.16 17:27, Torsten B=F6gershausen wrote:
> On 24.01.16 11:48, Johannes Schindelin wrote:
> (I had the same reasoning about the CRLF in the working tree:
> We don't need to look at core.autocrlf/attributes, so Ack from me)
>=20
>> +test_expect_success 'conflict markers match existing line endings' =
'
>> +	append_cr <nolf-orig.txt >crlf-orig.txt &&
>> +	append_cr <nolf-diff1.txt >crlf-diff1.txt &&
>> +	append_cr <nolf-diff2.txt >crlf-diff2.txt &&
>> +	test_must_fail git -c core.eol=3Dcrlf merge-file -p \
>> +		crlf-diff1.txt crlf-orig.txt crlf-diff2.txt >crlf.txt &&
>> +	test $(tr "\015" Q <crlf.txt | grep "\\.txtQ$" | wc -l) =3D 3 &&
>> +	test_must_fail git -c core.eol=3Dcrlf merge-file -p \
>> +		nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >nolf.txt &&
>> +	test $(tr "\015" Q <nolf.txt | grep "\\.txtQ$" | wc -l) =3D 0
>> +'
>> +
>=20
> Minor remark:
>=20
> Ramsay suggested a test that doesn't use grep or wc and looks like th=
is:
(That looked really garbled in my mail pgm. The suggestion is here:)=20
<http://article.gmane.org/gmane.comp.version-control.git/283261>
