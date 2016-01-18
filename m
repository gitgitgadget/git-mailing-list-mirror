From: =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
Subject: "git tag --contains <id>" is too chatty, if <id> is invalid
Date: Mon, 18 Jan 2016 22:24:31 +0100
Message-ID: <569D580F.4070302@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 18 22:25:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLHIJ-00047B-I1
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 22:24:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbcARVYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 16:24:37 -0500
Received: from mout.gmx.net ([212.227.17.22]:50315 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932282AbcARVYf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 16:24:35 -0500
Received: from [192.168.178.24] ([78.54.167.31]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0MdoR7-1aUoUG0OfF-00PeZm for <git@vger.kernel.org>;
 Mon, 18 Jan 2016 22:24:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
X-Provags-ID: V03:K0:+Sg0G8WPYioer8j9CfUHiDKQJ0h3krlsh+zSO14T2kbL08CYNF7
 0LbT45jFWqD34pOnO6wlRsio7UKDz/ucRc9tsWEfN64mSLf3MT1kWXBcEW1XWq4gJG1rs1I
 qNTHDH+6q6B4+PlnTAcBXp1lU/n9bbzq/RtYcr9KSK783IxiNWq/n/RT1Ul3BYG2K3rhMUm
 9ECH3pgUnHoIzyMqKfKBQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vuJsX/w2dvY=:Q7r10FQzZo8FDefoVGmkZs
 FlXnV0tPqtPK398wi1gmZQvy/TKe48Jb6sXy80lWSiIcURTyHEtRKzU+xgp3cFpPAXIdFL5Cy
 E85VtDe4Rkpo/c5c8p4UWf+52xo+xT3/63g2q+RdWAZsG7BcfiS7AGcSzdE7RwJZlt1wVAxkJ
 wIaE8J/TC3n3pCtTr6Ma0LKuyEJpxfxySZPgbft5k5McQTY3hPBnj4sbBfbjlM/Q7VEr84rIe
 sbVp2nLCV/QVCVxhl2TMPFGSufZ8V2yb2mwh2x2OyAyuIMDwSgfisMOKd54D2YJVD/1tn7cRy
 ExNHrJejI6Gs8MHpaNrYNIeF8guvJ7MBF6kQ1D3F77IFoVKem+VkHgLmWCshhTwqPI9dnUT0K
 VPjJOYRL1TlFJj1SaH4JaaPfM1dPLuEsr2Vp9GGsTghRi0h97ZjSB6zpqtkAeCTPW40Su3SDi
 ubXNFxXdj5aoOYy+UHJ/3FaQ5KsAHtn5WnmB4Y2skZggSOx+Aam8wEij//177L64rrW2nUlcC
 wafJJz7QZbiPJp8zYQ2JL0jXPXPNo8+yO2Sf4nI7WzKwP43eyS6+1Xu4YoNgMikaDGjwGAmJV
 znIr6Cimmr2Zoj8imgy0SOw7wru8DAyVGmoR7RoWioqy9WkVAKkG8kNmAZ82K4nJUuW8HoIt1
 EpfGwLrg4DuZ8lKucYeRCeCUG5IS2GSwwqzBGBZZUUHRhzksILzxw9+vKBNudg7xdqCEkokDr
 WEUxsBsmMGIqQOE3uPb2rAa0tq9Z20wNeYf+Y87FfZXrvCwavCQNVDo0cLocgCRGsvhW2nc/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284323>

 very first line is "error: malformed object name <id>" which tells all, or ?

-- 
Toralf, pgp: C4EACDDE 0076E94E
