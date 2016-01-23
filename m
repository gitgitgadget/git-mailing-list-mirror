From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 1/2] convert: add a helper to determine the correct EOL
 for a given path
Date: Sat, 23 Jan 2016 08:05:28 +0100
Message-ID: <56A32638.9060802@web.de>
References: <cover.1453482052.git.johannes.schindelin@gmx.de>
 <c4e6707b53d82cdeeb16c83bddf9c4870a53d9df.1453482052.git.johannes.schindelin@gmx.de>
 <xmqqegd9v4bl.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1601222003360.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 23 08:06:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMsH5-0002of-O5
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jan 2016 08:06:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbcAWHFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2016 02:05:40 -0500
Received: from mout.web.de ([212.227.17.12]:53170 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770AbcAWHFi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2016 02:05:38 -0500
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0MGicf-1aIBQ225PV-00DV9P; Sat, 23 Jan 2016 08:05:31
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.5.1
In-Reply-To: <alpine.DEB.2.20.1601222003360.2964@virtualbox>
X-Provags-ID: V03:K0:yB6kbrCtaumJjfkgKEpb18PoWeoBUq7a/scWsnTmIwhesLtF5we
 aHQxlnl4BLK/sbRMEXaNE/glmWzA4xBo1L++U1CoGsJyuOv6EO2af1B8TmZBsKCLAqcsPFi
 o2/LsMsZUMtWlueHVYIRyUhvNYGsxy26Qm+fPFVmWys8TyAHbzqIpDCh5qriNAFy3oWB87z
 KI3JGrbvDQ4wTM/d/2Vdw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zc9cVvBOk+I=:koUgDpIYzvHdn9hquYFeVK
 lg8TgCEpoQ/vDs34nyxFRYS7HqKO+lTJvWgCLNp0pVsVoNRtE0hSYwXsQi/DqqXw264fWH9tZ
 iAeavkH/9P7YgfpVnNPDRX5c8dHgpKbtQkZJ5wTR7aykmVOj8mPlFW4/fjzurX3qeWeJfy4hx
 OX5G2yBCvbyqGZohL6LdYtb6Pw9iuh340t5k2o88aPFjBgEh+Ich4JDahX/LiSiegfZNC/IQZ
 QTtPTw6/3B++cVAvrXpS6Bxeo6msRDT0hSfY3MBOzSL4ZA4mIaW2e85WPCIO9wWEQE/w/1lrP
 eq6uEe3lub542zApBV/A3yiA7SUxbMvwLnbbsl9u0r3R1G9P+g0eptx3aCS0JAozv1DuGNs7w
 Kb9O9vK7qupB2+cLB0KinSpVk/eoUO2Uw+HH6eXlYsIyKx9bB8i4FuCi162dqHhSeWp8pK8Yq
 HjnHxgElmar9pae4zy1xQiIjdTao1FeN03tCJ25kz+sVbh0bZ+ypdJZLxmyo4P+R1asBgR8A9
 jLo1nYVwfOnx/4Rzq5YGg+MDfzyKnxdP4cB7YEpHyYQCWxCoALHBOK4pYwLtLZUGw1C8vbC+3
 6Hcwgjo8qSZo1a8SSyTfzQi9XPLI77wdHedqXP1a3foM9CQ/p4FvPtzwB8FAaJoTNC7bKC0JF
 jdthq8AbVmGHxTE8eVnthMCuWe7ImEK+eQkt3cOiKxMW2NNLyTtRAqu5BliuPqhdtmk+gvnvu
 g9rCb5tucwrrcckjyO5ttMV6m5xpc6nXJ3uMb2GIX8c2/HHXU1o1+Gmf7chEHLxtxuBhrt9z 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284625>

On 2016-01-22 20.04, Johannes Schindelin wrote:
> Hi Junio,
> 
> On Fri, 22 Jan 2016, Junio C Hamano wrote:
> 
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>>
>>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>>> ---
>>
>> This change somehow ringed a bell and reminded me of your recent
>> ls-files stuff.  Are there things that these topics can use from
>> each other?
> 
> Quite possibly. I'll have a look tomorrow.

Something like this should do:
(Fully untested)

enum eol eol_for_path(const char *path, const char *src, size_t len)
{
  struct conv_attrs ca;
  if (!path)
     path = "*"; /* catch * text=xxx */
  convert_attrs(&ca, path);
  ca.crlf_action = input_crlf_action(ca.crlf_action, ca.eol_attr);

  return output_eol(crlf_action);
}
