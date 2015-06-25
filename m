From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@telia.com>
Subject: Re: [PATCH v2] commit: add commit.signoff config option
Date: Thu, 25 Jun 2015 18:36:54 +0200
Message-ID: <558C2E26.1040807@telia.com>
References: <1435243807-32112-1-git-send-email-cmarcelo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Caio Marcelo de Oliveira Filho <cmarcelo@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 18:43:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8AEv-0000Dh-1N
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 18:43:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbbFYQm5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 12:42:57 -0400
Received: from v-smtpout3.han.skanova.net ([81.236.60.156]:36420 "EHLO
	v-smtpout3.han.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751006AbbFYQm4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Jun 2015 12:42:56 -0400
X-Greylist: delayed 360 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Jun 2015 12:42:55 EDT
Received: from macce.local ([213.66.56.100])
	by cmsmtp with SMTP
	id 8A8yZ6Lu2Goaq8A8yZwXB5; Thu, 25 Jun 2015 18:36:52 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.0.1
In-Reply-To: <1435243807-32112-1-git-send-email-cmarcelo@gmail.com>
X-CMAE-Envelope: MS4wfA/3nx3rIyyAbTD7D46/tqnmwfapPGcslp5DZOKpn/tgiIm+kPAp/NSBTXct9g9x8/wPOnmBQpEqtNVkrT2IyuGRJfhv9Pl4wakCT0LMVdvR7dGgaMO6bAa4l7YZebF5rvcrVA7ttTRrATpfQyArfgJI0xl3sbRQRkp0yl3N96n0DBO2C2kq8b1zYjps2RTaRQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272693>

On 2015-06-25 16.50, Caio Marcelo de Oliveira Filho wrote:

> +test_expect_success 'commit.signoff config option' '
> +	test_config commit.signoff true &&
> +	echo "yet another content *narf*" >> foo &&

Minor nit:
The > or >> should be written without a space, like this:
>>foo
