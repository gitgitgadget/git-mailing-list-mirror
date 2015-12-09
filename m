From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 6/8] dir: add remove_untracked_cache()
Date: Wed, 9 Dec 2015 08:39:32 +0100
Message-ID: <5667DAB4.7000002@web.de>
References: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
 <1449594916-21167-7-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershause?= =?UTF-8?Q?n?= 
	<tboegi@web.de>, Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 09 08:40:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6ZM4-0000xu-RT
	for gcvg-git-2@plane.gmane.org; Wed, 09 Dec 2015 08:40:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbbLIHj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2015 02:39:59 -0500
Received: from mout.web.de ([212.227.17.11]:55681 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751785AbbLIHj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2015 02:39:57 -0500
Received: from birne9.local ([213.66.56.100]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0LwHkw-1aK7dx3y8s-0184kT; Wed, 09 Dec 2015 08:39:36
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.4.0
In-Reply-To: <1449594916-21167-7-git-send-email-chriscool@tuxfamily.org>
X-Provags-ID: V03:K0:1A5fTe9JDzPSIKblGMR37CcCgIit58NElPcNOWzLcteHAoz7imc
 AIN0EsVuFObmvhPbCzwo69EJqLxaFtdwa7K3n0fTeWxTuTVQ4VURWMqeLQPpoHG26aD3Ttq
 GM1JM8lpeJ75Ifl+cfl3zpv0xtV2xk0A5ITkc64gD0eX3NKy5nE7SXaZjfIhrdQNbCkTJqD
 SqNwFEhThun4vAW6Idn3w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:F/D4BO+RpqQ=:qqcGJaHd0NIDYseouS5zd9
 pMitpUU6LAQWG0jVSKfNbbizPamDc+bggREOvwStT05WxtkVOmAz36PrgXmGMxjqVt4sbCmUB
 HZWisKHebsIET6caCJ/CS+rvzaiOyLDbbEHmBUOo1qZMNCpTmhdQWma/dHSmIEy74U7SY1HzB
 mBoN987tgoONv96s+bmIFU4IqOFEywb/mEkqm83YGCvxxAVzoV7mudEJrElmQ/P2rPmqrpg6h
 WSE+leLPA6ajU2sTepqKbOZA1feKlhnTQJhTkWEpkzcfmlURLR/pRAG/ZfcSHhT9zfzMIStmj
 UavrI9amMAorvrphx36xBxSMC9p1rnEe7ZZ/HoKcBZGJvsZl+SPmVQKEJwmMNi96u0o3ZW51X
 GPYbBwTY8yxpm8KagtWLnhhRB/9gdPcQzmJW4Qq7zESXgaO7Fz66WLNLqBpcnKLYcJa4DSU6W
 RJdHy4AbFAKBaVooV+AuBZBRHFTtNgdY3zAAVLxBDcRx7Zq1/biZPHDy04PFfSpkd1OQm8YsA
 YIWrmp38+0WzRCOJ8lkJw7VJlPEn3RFS6dJabG1kWNnsUBnuGoEmmzGtNIBRgNaNANcVa0llH
 BTuD+ocQvir9F9p0En2uR1oqg5tp8CmUSGY73RkaIaD5LcA4PxRESZYcCVczAkTG4bgVIdChN
 rd1QgGCBbDgFp6oHvs2BG3lj1PMuHluqz8qwz/RxractdZUvmPmOEstZ9RWV/juqg49Ghi9ow
 3RETSitmInPsWBx51fItBou2SZY18VJaT3CYAxlojXofbeZfunEIflOzsp7Bv5EaFrkksr2V 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282187>

On 08.12.15 18:15, Christian Couder wrote:
> This new function will be used in a later patch.
Why not combine 5/8 with 6/8 into a single patch ?

(And please consider to mark the series with v2)
