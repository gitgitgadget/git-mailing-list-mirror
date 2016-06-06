From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] cherry-pick: allow to pick to unborn branches
Date: Mon, 6 Jun 2016 17:11:12 +0200
Message-ID: <303a47c2-b878-6dc9-abb0-0d948866c197@web.de>
References: <afafa51c-f950-594e-7142-5b28b1182add@drmicha.warpmail.net>
 <69f7973e353f52a62157ca59af5027c9617506a4.1465219182.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Fabrizio Cucci <fabrizio.cucci@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 17:11:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9wBf-0005hR-AU
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 17:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbcFFPLX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 11:11:23 -0400
Received: from mout.web.de ([212.227.17.12]:63914 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751806AbcFFPLV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 11:11:21 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MWjAd-1azJ5s1S0J-00Xwnx; Mon, 06 Jun 2016 17:11:07
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.1.1
In-Reply-To: <69f7973e353f52a62157ca59af5027c9617506a4.1465219182.git.git@drmicha.warpmail.net>
X-Provags-ID: V03:K0:z9tsqs9u67RfsAqWvpDO/3kDLJ6Hje53uS8zvek6E4VDtg+IFMU
 7PaTvGhQUKI8HxS7I1baqFo0guscodhE4FKuLeVyzjIN5Dopbi2flVGnVyF4X35auSgGP3b
 buXkefCECWkGZ1V4+a6QG+8Uf4nf63SPRQzjLZW/MHGNAf1XR1cw/Tw448f4GFDYIanEIxM
 n9HeyzLLQ0V0sD3z6d6/Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1bBI+6DwNpQ=:p+58Muq3oPbZGDED+JE975
 Dklh+e5JQx6XVn0BaTlWgkDyeeJTdJkIgMrh/CwPFo4UA1rXNk/Top1Rbh0bB7PXYhyQTAiFS
 arpfYXDWv0KwXHCg1jAAZIqyobZlDDMqCBBXX1kNp2fP4pE7esBzOD2y+ghei5BzYz0lP+Vk5
 J8lsv3LcoND1K27/CRUPnQL1rwi/jzp4DLsaTCNStFbNei1q4USaAXmeIKvmwHlIzGWjrSR+m
 jzSKhmhY8u0oYit6QxgGyF6/TkiqQRQlpt32gm4AG0wH1sJo8appUS2Ik0UMRUJMgxv+oifdw
 2ENM43SKOkNPByBD412zvL99adtx780XlUDCSE6XevvTpIa++gMH3uzECW/mSU8nSLA0O3w7m
 trUQXVWs76v1qHV0Nhleu/XuRbhT4oxKbYbkSjmP3T5iLQqPc/Ui7cdglDCocZy1gZU16Tisg
 3L7PF/U8Q+dHMamLWdCbXEdrEjS9YoMMfHrZgJxDZE2CkZCbqUgHX7roqtszlVwY3OQEKqkFu
 mh9Ad3BsnTins4Rnw6ZTLYRQjmJzu7eggVpNNf70w4R7K+3WObDIN3GD+uqfecJhaFD2Z74X1
 zIQ4CGth4qBu0Xo4v0HYbg/vqZhN0xcnGUoCAUxMYwwwCIYJvAMQx9S+LSLxjvAbOJGkYfM88
 IuBdRTwQ9xDWq/dKH+RzYS4+oXmkEzDJhsAwl4tfyDrWw9xmqES8FCJdrp8Wjxc97QNKRsl7J
 zJ9eYIeQv1twzrLI0DZKflKalHAXxE+1EYVWIHRkWGR3TxKdfYviAW28zprlYxS7Nh6y32pr 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296515>

On 06.06.16 15:23, Michael J Gruber wrote:
> Currently, cherry-pick allows tp pick single commits to an empty HEAD
Typo:                           ^^
