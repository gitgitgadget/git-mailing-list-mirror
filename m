From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2 2/1] support -4 and -6 switches for remote operations
Date: Fri, 12 Feb 2016 16:43:38 +0100
Message-ID: <56BDFDAA.2050607@web.de>
References: <20160128225123.GA20045@dcvr.yhbt.net>
 <xmqqegd1l13l.fsf@gitster.mtv.corp.google.com>
 <20160130085056.GA20118@dcvr.yhbt.net> <20160130131353.GA20429@dcvr.yhbt.net>
 <56AD4887.3070207@web.de> <20160131000144.GA10117@dcvr.yhbt.net>
 <20160131011314.GA22855@sigill.intra.peff.net>
 <20160203040914.GA19840@dcvr.yhbt.net> <20160212113146.GA5520@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 12 16:44:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUFtE-0008B2-9d
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 16:44:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbcBLPoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 10:44:07 -0500
Received: from mout.web.de ([212.227.17.12]:52981 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751189AbcBLPoG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 10:44:06 -0500
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0MVLWc-1aVm3n3dKY-00YlfV; Fri, 12 Feb 2016 16:43:41
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.5.1
In-Reply-To: <20160212113146.GA5520@dcvr.yhbt.net>
X-Provags-ID: V03:K0:mXZ3uVbYKLHynzc8nx330xnvyM/lhiHEiDTqdbMmVyfOuoFiVXG
 J3MxXdCAL7ynIN+C4L5AMglGB6f6k5OXJ1AmnIAkGWLCoXDjDS++pU+FxP77bhYIAW/n4I5
 ata1sEgPnWPdD8YnDkWr0Tks/QWPUcpT77HfIPWdEh8lww7e7diO0kW9lkg6Zc2ZkW33lmV
 eZSdjazyPEEIG1FOZIlGg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:g4paHVAjNHc=:QRZKGMm0yau1Y2j/qh5kWd
 SDYPzObZEVNH9rmvHrIz1BLPmD/AvN+Ewsvzxbqis2cGFRKZE3/XZa8BQ0ggxtEydCOXCfdKO
 91PLaZLgE2WUTpcwOCIQ8+WKg6e6cjbau/+rb/NsLzzZ6QKjEZgvfijRxDCMvFt2jn9WvaNIL
 voZOXBXpDzHkBNOEMSLpxdVXkh2YsaVJvBIrxIs3nFCE0q6Eo/5KcMDN3GFhwvO7eYYwPQvGp
 D5T1uuXYpmqgtT/K/a52Uk7KDurlxKcGkFgRrxjiwp4GPY0vwLGdvc7zxCvbHmJkkYI9Dn3it
 z/+gWWobfEUA2W13kc1afBrkPfTQ2zVkY/rsxkpsus2EtzNqVCqRdGO6p9wVauaepWPt+oMnH
 sIIMSY2uluWzTbbfVWfQqZebKkmi0YPM/fxA1whPMXM46WO0LlB2IoD+POn0hBCNRGmCeVMCf
 b+N2eqcQ6hYnPgYbEEhzEs29/M8KScMq635Sa5j0jXlj1uW8ZijmQq670u9CHOfvvRyzj5Nh0
 2YI8pop/halaxbafY5nm82WAhiVPPzt5j2feA/TwRNnSQwjfCFzN+Zd2eNKFg+zVkNNpbWn5V
 //Xcf2k+F+5G9NfE6gTOclgKKri8oGbf/y0axl+4Uzz4nXDQWfGd4BcTsStcsFFqOcsTSuQ6j
 K/rPl7h+mEnynXYw19Xam0wtoyBkxHgHko6IdEpuO+aIfZMGycw0YxQyekliicnOgAULILZ2L
 aqiRQzZ+pA6t4Wy8cf0IpziuSy46QFiAiiw/FzLYaOssY+frPQ+li6IFmx91Crt37rOHRsTG 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286055>



On 12.02.16 12:31, Eric Wong wrote:
> Eric Wong <normalperson@yhbt.net> wrote:
>> (no rush to review this, unlikely to be around the next few days)
> Ping on v2.  I will be online the next few days and likely
> working on some other git stuff anyways :)
Patch V2 looks OK for me.
