From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2 1/1] merge-file: let conflict markers match end-of-line
 style of the context
Date: Sun, 24 Jan 2016 17:27:16 +0100
Message-ID: <56A4FB64.4010609@web.de>
References: <cover.1453482052.git.johannes.schindelin@gmx.de>
 <cover.1453632296.git.johannes.schindelin@gmx.de>
 <d71c7abddd4cba85b967f9fe1d33c7c843176ca2.1453632296.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>,
	Jeff King <peff@peff.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
To: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 17:28:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNNWO-0007j2-OD
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 17:28:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753282AbcAXQ1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 11:27:35 -0500
Received: from mout.web.de ([212.227.15.14]:63384 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751644AbcAXQ1d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 11:27:33 -0500
Received: from birne9.local ([213.66.56.100]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0MK2JZ-1aMYYx2H7V-001QR6; Sun, 24 Jan 2016 17:27:22
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.5.1
In-Reply-To: <d71c7abddd4cba85b967f9fe1d33c7c843176ca2.1453632296.git.johannes.schindelin@gmx.de>
X-Provags-ID: V03:K0:eaTlPtYNgBJv8AHi7w9GuT7P0CCY/GFiD/4c4yYHlKuKNjiUVYk
 tire8w8QEi/ZkxEYTKriNm3lZ5h/DM4qndAkQE/6Et9Gs4d7mkIKfmisTivnYmDJnEzfK7D
 n744z3Xrkbf2CIs/fNClo6FSOhCsObH0pXRP9ryE1wYTHvILid5BIkInOanpDKl6s03sZ0a
 7S7ZfujiB7BpEW+LfshPA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7+v7mdJiiyE=:tCOZFu6Trx+HMsgFDGckhC
 nbDOIviPofk9fh6ax0WmEQtBEX6emKmfwPQvJDVEO4A1azIw6GGVKAW3mfflK7D5qWvp0Xdnx
 DPnD9BTKApVkc3P3k39ZOfnul+P9SpIYMBXCozW2R7nFLPf+OFyvL9mMbQuTOWgQ2IQiSM0y1
 wPfIkoFrk/+spMDOhWEhdAPueQ6mlrYB9dAW54zsWVBNMNd1crUnMTt07WCa5A6PrAR2ODCBI
 yyFIfq2KQW4yova196ZeXgJUL5OVOs3IUQ33b42Rf2xfDYSNLmbUVJ5jvtCmYct+vd1gZOmVq
 u4x1pVvusYlcO6qJyOvLiHqsKaF5Tibk2M6k071ounFk3Vj0Fy4A1OcSNsB7omfJROqQfTVYq
 3bubRGtapGBNbHtVEEHmH04jh9otWFylk2B9ceEEpmGvfuD7ya2wDNXltL8QTlBX/mIWLA01I
 +pg9iNtITFvJhty6QjcSHrvvSBs81ZHlGWjv17PFKd7V+Rz20gS5K4fozBaUOglFWT5yUC4xy
 nKjt0FkjbKX+5VKHYKZh5qYN/2ZDU+9YkZzAXtSmz7p+FuKzmroP5qegv4s+v4PMpRQwT66qe
 DMGVP4NvIuueDNnIoLq1W2Wag6QAt5aeAwZNPl9sIMg6Y2dqkxLdGVl9eo8PTRPxxwYSfjt8T
 mW3EjNCeye5XQKLu51fuWAMDyAwaE+OMHeHlvkF6q1u/lFIXLyjERCvE6uQgrY1sL64nukq1E
 5bajejV52dV31kLL37Oy7lV+FntB5tzUIN+I8g3BEDmq3uuy8xFqREUYiv7X8Kbra+4VDH6D 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284685>

On 24.01.16 11:48, Johannes Schindelin wrote:
(I had the same reasoning about the CRLF in the working tree:
We don't need to look at core.autocrlf/attributes, so Ack from me)

> +test_expect_success 'conflict markers match existing line endings' '
> +	append_cr <nolf-orig.txt >crlf-orig.txt &&
> +	append_cr <nolf-diff1.txt >crlf-diff1.txt &&
> +	append_cr <nolf-diff2.txt >crlf-diff2.txt &&
> +	test_must_fail git -c core.eol=crlf merge-file -p \
> +		crlf-diff1.txt crlf-orig.txt crlf-diff2.txt >crlf.txt &&
> +	test $(tr "\015" Q <crlf.txt | grep "\\.txtQ$" | wc -l) = 3 &&
> +	test_must_fail git -c core.eol=crlf merge-file -p \
> +		nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >nolf.txt &&
> +	test $(tr "\015" Q <nolf.txt | grep "\\.txtQ$" | wc -l) = 0
> +'
> +

Minor remark:

Ramsay suggested a test that doesn't use grep or wc and looks like this:

test_expect_success 'conflict markers contain CRLF when core.eol=crlf' '                                                                                                                       
  test_must_fail git -c core.eol=crlf merge-file -p \                                                                                                                                          
    nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >output.txt &&                                                                                                                                 
  tr "\015" Q <output.txt | sed -n "/^[<=>|].*Q$/p" >out.txt &&                                                                                                                                
  cat >expect.txt <<-\EOF &&                                                                                                                                                                   
  <<<<<<< nolf-diff1.txtQ                                                                                                                                                                      
  ||||||| nolf-orig.txtQ                                                                                                                                                                       
  =======Q                                                                                                                                                                                     
  >>>>>>> nolf-diff2.txtQ                                                                                                                                                                      
  EOF                                                                                                                                                                                          
  test_cmp expect.txt out.txt                                                                                                                                                                  
'
