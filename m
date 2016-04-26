From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] string_list: use string-list API in
 unsorted_string_list_lookup()
Date: Tue, 26 Apr 2016 17:42:50 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604261742390.2896@virtualbox>
References: <20160422173500.32329-1-ralf.thielow@gmail.com> <20160425174000.24943-1-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 17:43:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av58d-0001au-VJ
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 17:43:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbcDZPm4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 11:42:56 -0400
Received: from mout.gmx.net ([212.227.17.22]:64830 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750843AbcDZPmz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 11:42:55 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MarAM-1b9zcW2Gny-00KRVr; Tue, 26 Apr 2016 17:42:50
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160425174000.24943-1-ralf.thielow@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:T5s/+Ko2EUDfNz9xVKfL1ctLGcDflSYn1Iu5m2Zd3yJ53kqQ8+B
 gdaDXtsor2lC2eUym5KQAErfUjv3EUnx956edvZJcbGU24IHfyRRYNu6IM4RUiQAuW2mwID
 wLW7l/evvfLPDU2iN4mMFqP+xfUFdDwg3ZMilf9i3CLKJskXjc+ns28uJgWXNvP7jcI5ZpX
 bVXS6IDejUs38uwANojhw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:POl8UDdfAUw=:M42Y6Ubyd4z5VA/fdZW0KD
 OlULRZ4WFN66MP9xFsq+588JkvYVIJCHYFAg+uKfB324UJUmBeR+w7KJ5W5S0moa0tEGeCSqs
 7eghpS/LyfvhdZQhdtONrN9JmlYxQ5vU65BDTN8rruTdPT3+k9EQar3PQtDJ+fyxfnApSLClj
 fAnInF9M4Lqs6CT5axaErrKfz9RIV+3l0hX7729GzQmjy4ao1KoZOqA8BTQrrrP0YsaL7PUqP
 fZA39NSGMetn4iNw68YZaGaxzvgxU8AqNtTV2i3+X3uFsclBHfunvoBaGiGJZ8ZYWRfO+V1Lj
 7yZ9njsEgfOROY4H6w7jeciejQOD5rojjxNP/qlN4bUKd5QjD1WySwN42Ecc2FrSHmQWo1GJt
 YgHVHHXBC/+RXgkeVRzkxP9erXPE2v4utH8nMOEpl2smenMlzVIqaxu2SFBCQ9jBikGc8WXOA
 MMvk2BQXkOMUNYji14cyE0bi1qRKgWjVwTGJHQakAHelDgwzTq9qAyMn7QU7vJ7Fp8UfsYeKT
 W8pixsF+aPq5t26AJPjRdNOAFXdeoDMBmrYNLf1DZjvgcsnwc0iyzXbZAKl8s0q0M2CrqVpXk
 jB/wLmoISmnvU1O1s2UPjkUyj+uKzOoKQYyN8NWLjt1SRIpooOIMc1hNUtLDFX32OEhMdkGau
 gt1nkvcexPUmJoMn6bgjq3LWFlia65SL1l2L4kfwyVsLg0I2JQmheoDuw73TfjIUlMp9DW6SA
 vRsIf+EpJmlTrcx4Ap2yiO125k7oo6yuZyGoRDKDG8z6r6yykYmWW8dVww1PGM5yvM2ce5Mk 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292606>

Hi Ralf,

On Mon, 25 Apr 2016, Ralf Thielow wrote:

> Using the string-list API in function unsorted_string_list_lookup()
> makes the code more readable.
> 
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
> Changes since v1:
> - remove extra curly braces

ACK!
Dscho
