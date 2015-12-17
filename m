From: PFDuc <pierre-francois.duc@mail.mcgill.ca>
Subject: Re: Git issue report : issue with capital letter in folder name
Date: Thu, 17 Dec 2015 18:35:25 -0500
Message-ID: <567346BD.50703@mail.mcgill.ca>
References: <5672D895.7030209@mail.mcgill.ca>
 <CAGZ79kbi-qdaNorabfZkFFL=FDZSgD332+N8bUrqfvu621EYvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 18 00:35:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9i5U-000686-UR
	for gcvg-git-2@plane.gmane.org; Fri, 18 Dec 2015 00:35:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627AbbLQXfx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Dec 2015 18:35:53 -0500
Received: from mail-bn1bon0064.outbound.protection.outlook.com ([157.56.111.64]:12992
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751991AbbLQXfw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 18:35:52 -0500
X-Greylist: delayed 27291 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Dec 2015 18:35:52 EST
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pierre-francois.duc@mail.mcgill.ca; 
Received: from [142.157.147.3] (142.157.147.3) by
 BN1PR0301MB0705.namprd03.prod.outlook.com (10.160.78.12) with Microsoft SMTP
 Server (TLS) id 15.1.361.13; Thu, 17 Dec 2015 23:35:50 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
In-Reply-To: <CAGZ79kbi-qdaNorabfZkFFL=FDZSgD332+N8bUrqfvu621EYvA@mail.gmail.com>
X-Originating-IP: [142.157.147.3]
X-ClientProxiedBy: BN3PR16CA0046.namprd16.prod.outlook.com (25.165.72.142) To
 BN1PR0301MB0705.namprd03.prod.outlook.com (25.160.78.12)
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0301MB0705;2:Wmaav87lS7RwvlhHs6KjmkLANPIYxwFsK+iEHpUSVR/7BOx3MJ6vp3ubTUKhaQqgNWoDKXJ6o0HrHIk3rwQ+bSxddQTcP2dyM1+f3x3M8fkTBRa6og6NTXmfBrfslTIzPGiD2tRSwbUEzvdqBJHYpw==;3:ntDYBm9FvLqIb+fgt+yjr5anaeZ2KfdAa329DDo22Jd2ryRDyfg6deRu4a9U22MurcvZ3NHHD6b4ipurCbKO65fcSHUqxMjifV0aLwaeG9WDrpm6uGRUcUrSdtb5kKQKQkqLbv/POBWuf1REwembhrontCRuDaOZoq8rVL5vbF2KPzB4K68v86S4yws7vF1m;25:+8nD1f4zZNH+jWCXPRHKlT26wCg9JM3b0dPxkI1pVlJTJZCwQY1no9bkOKqpBu+Oo4vkVciEbPF4R5nAr2ckyjvjbTnOs8mwpLCgcIt5JWoPsYk3cuUofg8NBn1TevaPyAzYO9pcwEP12hpz17YLy1Al/xRGsWLpXNNY6UwiCAsET0So38mZPtpZ5wNwquSjyujliSr/xKBYabT3ImaRRcnSwuKJtLiOQCApkCOP639GDBTtkxtThjv+/DaJkiVC8acIMcyulgtuYoZQslMNSQ==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(42134001)(42139001);SRVR:BN1PR0301MB0705;
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0301MB0705;20:kyLHZBQdetHQD6e15kCZl1wwqlCrinGBUeY4bLLlVHvVm1u/ClYQlAobEANNCeqiCDMjUO9gtoB9pg/xstFvXDeNxFG+5pxKyYzeGvNVf/7YdZ0WfcqaqcvB6Rpj2DMy/t7FM4cxoSFZImPOFgSgRdFgCx9gmXCrtl/28l/LGH25jgu0sverRlZKY8bZG/+3jtYTeHhOdQbOOaLU0xxhegN1aW/XEERjqL7/Z0kDjSttPr1EKfVAAfZySHWa8g/hm9YyMoHBsUTH0FwDdvpVj/K5RqIjUa2lM6QyRj3K0dTOmN4PMJ614GO6NlhxL0yjxa1myWaoU9ehpv//NWZ8L8daPu9laFsSHGQQlFhnA0duM37G/5ZASXnEvuSnQwyjKpe22M/Sa0db7/RMeGS/LVBpms3VzbcqOmTIKy8NqxqRyPx56HYBrzXXXgSgkKxPhea55hJXrCUmjzqUY1/i7zs1EoSgoL2nF47Z9c5Eb8UYwtGUpfaHimEiy4xEErt7;4:rS8myvJtZAAKI39MurXiUwAhHfkapMXdXj1xK8KuKR/guM1UZolFZ+lOuTOlRES/nloriUJxer9SEFC5wyZEVNa3SM6mFe1I4Mj6S6i828fzsssXA6WyzRVE2J3guRoblya92bJqF7EAUMsi/ShwVZCxwYQY9WwzoGPDtCZp93Zoj8xj2h/jSpmA7dHVb3WdknbVsMwEWpsp8xcdacJFTGGBEdp6xtq1HWt3ne
 xsXvUUxQ8VPGmz0n+xMNDbUaqhgojaCUIm89AjggPFYfgN9VxUSGomLcguXzcwh4esANSBmisi0l14mRMiCD+uGDKeLYliQuyv 
X-Microsoft-Antispam-PRVS: <BN1PR0301MB07053E84768A5B072F4612E194E00@BN1PR0301MB0705.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(520078)(8121501046)(5005006)(3002001)(10201501046);SRVR:BN1PR0301MB0705;BCL:0;PCL:0;RULEID:;SRVR:BN1PR0301MB0705;
X-Forefront-PRVS: 07935ACF08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(6049001)(51694002)(189002)(377454003)(24454002)(199003)(377424004)(76176999)(42186005)(50466002)(65956001)(66066001)(33656002)(19580405001)(65806001)(50986999)(19580395003)(47776003)(54356999)(83506001)(64126003)(65816999)(74482002)(86362001)(87976001)(4001150100001)(81156007)(97736004)(189998001)(5001960100002)(5008740100001)(3846002)(110136002)(40100003)(586003)(77096005)(2950100001)(6116002)(5004730100002)(4001350100001)(101416001)(23676002)(1096002)(122386002)(15975445007)(105586002)(106356001)(92566002)(3940600001)(422495003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN1PR0301MB0705;H:[142.157.147.3];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:0;LANG:en;
Received-SPF: None (protection.outlook.com: mail.mcgill.ca does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjFQUjAzMDFNQjA3MDU7MjM6d2VOSUlEVFUyRENwNmM5UXNlYlRSQWIr?=
 =?utf-8?B?NzN4UTNDR2MrU3VQcmZ1TlkvYkwxNnFZRUQxdjZtb2RxZGxURC9zeUhvU20v?=
 =?utf-8?B?UTdCU2Q2U2l1QzZ6RW9IbFBlTFJ6VTUzMlVVdDlwQ3Y1WVRYUzZGaE1xUWox?=
 =?utf-8?B?S3l5cllqOW5mZVg3bnNsdGN2dFUyMkRpOHRLU1l4RG9uRUYwTTlrWUN1VGhI?=
 =?utf-8?B?cmd0czVZeEV2ak1kUmtsdkJqVXYza1pYcmxCRDcybHNYcUVuZEZSeXA5bmpu?=
 =?utf-8?B?eElJZElvS1lhWkxsSmJ1c2h3SXo0ZnZGekNSVnArM25QYXZDZ0NaUnNnSzJS?=
 =?utf-8?B?ems1QldQdkova2tQR01UTjE5aFBiTWtpTllpekdRQXZQbVVPc0dWR3A1d0Q4?=
 =?utf-8?B?eUszNGJjdUhBMGpuOUtOOWJ6cDJrbjVTUTFKT3l1ZnZWZVRQWi92dkVGRFBl?=
 =?utf-8?B?b01VeUhHSXZxVm9aTDluVDk0VjQ2Y1RZVnExMENQM3krRkxqeHhENzZBR1o3?=
 =?utf-8?B?RE1mb1h4NmRWeDgrUEc3Q1h6ZVJvck94M095R2tDOVdtbWhVaGpNRWdBeXIx?=
 =?utf-8?B?dmp6bkRIenN0c0xBZVQxQnhTcnRoeWVJdEhvTnhKK3BnV0l4bzQ0dHQyamZL?=
 =?utf-8?B?TGJPZTc5WGNIQjFvVmZoTHhWTys5NnFTd1hRV1V5S3 
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0301MB0705;5:wr6WZEVXK3xOVrrC8wdQz1qWmA/C2/I+shi/t3Xojw1Th30famfQiB1C4GCwo2zhkW4igDxJP6m34V/sm/h56+n008nZum6l1+/owHYJvV9VhxUGXffuY1IE0u7aTTvMyBCN+vzn2o1zHYTiSuoG0g==;24:XILGxiN4LTDy5n8+emFdfSuYI+65A/AClcaQaPiAZ0UXXyidSo3YlKM5hZk5qgkqCbG5sVHOZHYSVeZKaVPekiKGIYb8jPdVXjJUD95oAdw=
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mail.mcgill.ca
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2015 23:35:50.1445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN1PR0301MB0705
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282687>

Le 2015-12-17 13:29, Stefan Beller a =C3=A9crit :
> On Thu, Dec 17, 2015 at 7:45 AM, PFDuc
> <pierre-francois.duc@mail.mcgill.ca> wrote:
>> Hello,
>>
>> first of all thank you for developping git !
>>
>> I had an issue with a capital block in the folder name inside my git=
 repo.
>> The folder in my local was named "Display" and the one at origin was=
 named
>> "display" resulting in error when importing python code from this fo=
lder for
>> users who got the repo from origin.
> By any chance, were different operating systems or file systems
> involved in creation of
> this problem?
It might be the case, a mix between windows7, ubuntu and macOS
> There are file systems which care about the capitalization, and other=
s don't.
> So if you have a file system which doesn't care about capitalization
> of the folder/file name,
> you can use a different capitalization and it still works. If you tak=
e
> the code to
> another system then, which is a bit more careful there are problems o=
f course.
>
> The main question which remains, is how is Git involved? i.e. would i=
t
> also happen
> if you just transfer a tarball? Did Git itself break anything?
I don't think git broke anything it is just that the folder name was no=
t=20
being changed to the one with a capital letter when I pushed on origin,=
=20
the only way out I found was the one I described in my initial email. I=
=20
thought then the problem might occur from git, but as you say it is=20
probably a cross platform issue. The folder initially created was named=
=20
display, then I changed it locally but git wouldn't recognize it as=20
something to commit (platform windows7)

I just wanted to let you know in case it would have been an issue you=20
wouldn't be aware of.

Regards,

Pierre-Fran=C3=A7ois
>> I tried to change the folder name on bitbucket.org but I was unable =
to (or
>> wasn't smart enough to find how to).
>>
>> I fixed the issue by deleting the file from my local, then commit, t=
hen
>> push, put the same folder in my local, then commit then push.
>>
>> I am therefore only writing to tell you that story which is not so
>> important, but I had the thought that because it is not so important=
 maybe
>> nobody reports that and the bug (if any) cannot be fixed.
>>
>> Have a good day and happy end of year season!
>>
>> Regards,
>>
>> Pierre-Fran=C3=A7ois Duc
>> PhD candidate Physics McGill university
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
